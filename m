Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbVFUUmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbVFUUmU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 16:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVFUUjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 16:39:20 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:6863 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262321AbVFUUiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 16:38:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=pERX9FSc4kozb55HYn7TnfFlZjA/RzKxRHPv36TmPcTiReT+MO5NA++9ZO6gGb+Xw/JUQPIULkkYvwiGxbCOuK5q8RaPUx9mplWnmn6i9prt9+l1NtSbrOT1ga5e76oPAeNnhMfaAZEnD9gbVgJLImxwfW1DIjbAsy04AefGBuk=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: 2.6.12-rc6-mm1 oops on startup.
Date: Wed, 22 Jun 2005 00:44:00 +0400
User-Agent: KMail/1.7.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42B46C18.2030101@superbug.demon.co.uk>
In-Reply-To: <42B46C18.2030101@superbug.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506220044.00190.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 June 2005 22:46, James Courtier-Dutton wrote:
> I have used the kernel.org normal kernel, and it compiles and boots fine.
> I then use exactly the same .config file for the 2.6.12-rc6-mm1 and it
> fails to boot.

Please, try 2.6.12-mm1.
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm1/2.6.12-mm1.bz2

If it won't boot, I'll file a bug at kernel bugzilla.
