Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278807AbRJZSav>; Fri, 26 Oct 2001 14:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278823AbRJZSal>; Fri, 26 Oct 2001 14:30:41 -0400
Received: from taifun.devconsult.de ([212.15.193.29]:42770 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S278807AbRJZSaf>; Fri, 26 Oct 2001 14:30:35 -0400
Date: Fri, 26 Oct 2001 20:31:09 +0200
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: linux-kernel@vger.kernel.org
Cc: Alex Larsson <alexl@redhat.com>
Subject: Re: dnotify semantics
Message-ID: <20011026203109.A32245@devcon.net>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Alex Larsson <alexl@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0110261139190.10309-100000@mjc.meridian.redhat.com> <20011026121628.O23590@turbolinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011026121628.O23590@turbolinux.com>; from adilger@turbolabs.com on Fri, Oct 26, 2001 at 12:16:28PM -0600
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2001 at 12:16:28PM -0600, Andreas Dilger wrote:

> So, monitor the parent of the directory in question for attribute changes.

... which is a little bit difficult if you want to monitor the root
directory.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
