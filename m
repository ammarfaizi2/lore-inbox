Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313206AbSDJP2Q>; Wed, 10 Apr 2002 11:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313207AbSDJP2P>; Wed, 10 Apr 2002 11:28:15 -0400
Received: from codepoet.org ([166.70.14.212]:8601 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S313206AbSDJP2O>;
	Wed, 10 Apr 2002 11:28:14 -0400
Date: Wed, 10 Apr 2002 09:28:13 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Amol Kumar Lad <amolk@ishoni.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Reducing root filesystem
Message-ID: <20020410152813.GA22103@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Amol Kumar Lad <amolk@ishoni.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <7CFD7CA8510CD6118F950002A519EA3001067D06@leonoid.in.ishoni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Apr 10, 2002 at 07:38:09PM +0530, Amol Kumar Lad wrote:
> Hi,
>   I am porting Linux to an embedded system. Currently my rootfilesystem is
> around 2.5 MB (after keeping it to minimal and adding tools like busybox). I
> want to furthur reduce it to say maximum of 1.5 MB. 
> Please suggest some link/references where I can find the details to optimise
> my root filesystem

busybox and uClibc are both a good start...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
