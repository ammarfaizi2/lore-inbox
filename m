Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262044AbVAILGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262044AbVAILGn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 06:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVAILGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 06:06:43 -0500
Received: from dsl-80-46-84-225.access.uk.tiscali.com ([80.46.84.225]:8064
	"EHLO lincoln.lincolnshire") by vger.kernel.org with ESMTP
	id S262044AbVAILGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 06:06:40 -0500
From: Chris Lingard <chris@stockwith.co.uk>
To: Michal Feix <michal@feix.cz>
Subject: Re: Conflicts in kernel 2.6 headers and {glibc,Xorg}
Date: Sun, 9 Jan 2005 11:06:16 +0000
User-Agent: KMail/1.7.1
References: <41E0F76D.7080805@feix.cz>
In-Reply-To: <41E0F76D.7080805@feix.cz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501091106.16050.chris@stockwith.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 January 2005 09:20, you wrote:

> Yesterday I was recompiling my Linux from Scratch distribution for the
> first time with Linux kernel 2.6.10 headers as a base for glibc.

Linux from Scratch uses sanitized headers; if you want to use raw
headers, you should be able to solve your own problems.

http://www.lfs-matrix.de/lfs/view/stable/chapter05/linux-libc-headers.html

Chris Lingard
 
