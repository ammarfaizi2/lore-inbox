Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVAMEtU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVAMEtU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 23:49:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVAMEtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 23:49:20 -0500
Received: from web60610.mail.yahoo.com ([216.109.119.84]:14719 "HELO
	web60610.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261507AbVAMEtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 23:49:12 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=AXi1TkuAlrgcqECwPIrkSqws5U0FBfP+23QPdi4ZEaGbzqZzOL39JjwBep4k4ouI8Xy+432ihEKSTjlE7YJGDQ4MkWrSo3U+y/juBcCurY/IyxYJb7cC7p7riL9mFMBwRONWYAT8VpYuGoIDApSjTQX2bzrNNxEMcVnLKQ7DA64=  ;
Message-ID: <20050113044912.40078.qmail@web60610.mail.yahoo.com>
Date: Wed, 12 Jan 2005 20:49:12 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: exporting /proc entry for module
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41E53F27.9000502@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Chris Friesen <cfriesen@nortelnetworks.com> wrote:
> To fix this in the future, export a /proc entry that
> when written to 
> causes your module to properly clean everything up
> and prevent anyone 
> from getting new accesses.  This then allows you to
> remove the module 
> cleanly.  Note that it may not be possible to
> cleanly deregister, 
> depending on what your module is doing.
> 
> Chris

  How can I export a /proc entry for my module?

Regards,
selva


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 

