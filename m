Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135263AbREFJCI>; Sun, 6 May 2001 05:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135266AbREFJB6>; Sun, 6 May 2001 05:01:58 -0400
Received: from gate.in-addr.de ([212.8.193.158]:30217 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S135263AbREFJBl>;
	Sun, 6 May 2001 05:01:41 -0400
Date: Sun, 6 May 2001 11:01:33 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re:  [patch] 2.4 add suffix for uname -r
Message-ID: <20010506110133.K3988@marowsky-bree.de>
In-Reply-To: <Pine.LNX.4.33.0105060334390.1549-100000@asdf.capslock.lan> <3437.989135106@ocs3.ocs-net> <20010506101217.H3988@marowsky-bree.de> <20010506013605.C31385@thune.mrc-home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.3i
In-Reply-To: <20010506013605.C31385@thune.mrc-home.com>; from "Mike Castle" on 2001-05-06T01:36:05
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-05-06T01:36:05,
   Mike Castle <dalgoda@ix.netcom.com> said:

> On Sun, May 06, 2001 at 10:12:17AM +0200, Lars Marowsky-Bree wrote:
> > You assign a new EXTRAVERSION to the new kernel you are building, and keep the
> > old kernel at the old name.
> 
> Except that some patches (ie, RAID, -ac) use EXTRAVERSION. 

So? You can still set EXTRAVERSION to anything you like. It is just an
identifier for the admin, and not used for anything inside the kernel.

Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

