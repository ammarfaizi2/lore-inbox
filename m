Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293187AbSCWO1Z>; Sat, 23 Mar 2002 09:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293201AbSCWO1P>; Sat, 23 Mar 2002 09:27:15 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:32775 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S293187AbSCWO1G>; Sat, 23 Mar 2002 09:27:06 -0500
Date: Sat, 23 Mar 2002 15:26:56 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ORBZ is dead, don't use it...
Message-ID: <20020323142656.GA22388@merlin.emma.line.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020322225305.B27741@mea-ext.zmailer.org> <Pine.LNX.4.44.0203221303400.1434-100000@blue1.dev.mcafeelabs.com> <20020322231851.C27741@mea-ext.zmailer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Mar 2002, Matti Aarnio wrote:

>   Teach sendmail to differentiate the cases...
>   (and qmail, and ...)

qmail has no native RBL support, that's instead provided by third-party
software (and that software is broken by design in that it rejects the
connection, without letting postmaster complaints through...)

-- 
Matthias Andree
