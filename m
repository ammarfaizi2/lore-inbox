Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262213AbVCEQgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVCEQgv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 11:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbVCEQaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 11:30:18 -0500
Received: from mx1.mail.ru ([194.67.23.121]:22299 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S263105AbVCEQZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 11:25:37 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: gene.heskett@verizon.net
Subject: Re: diff command line?
Date: Sat, 5 Mar 2005 19:26:00 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200503051048.00682.gene.heskett@verizon.net>
In-Reply-To: <200503051048.00682.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503051926.00430.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 05 March 2005 17:48, Gene Heskett wrote:
> What are the options normally used to generate a diff for public 
> consumption on this list?  
> 
> The -???? stuffs is what I'm looking for.

Documentation/SubmittingPatches section 1.1.

-up or -uprN for tree vs tree.

	Alexey
