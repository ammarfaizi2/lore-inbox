Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135970AbRDTQlH>; Fri, 20 Apr 2001 12:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135967AbRDTQk6>; Fri, 20 Apr 2001 12:40:58 -0400
Received: from coruscant.franken.de ([193.174.159.226]:47632 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S135970AbRDTQkn>; Fri, 20 Apr 2001 12:40:43 -0400
Date: Fri, 20 Apr 2001 13:37:22 -0300
From: Harald Welte <laforge@gnumonks.org>
To: Jonathan Lundell <jlundell@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Documentation of module parameters.
Message-ID: <20010420133722.D2461@tatooine.laforge.distro.conectiva>
In-Reply-To: <3ADBB8C9.CC7FD941@nc.rr.com> <p05100b07b7017fc83c2e@[207.213.214.34]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <p05100b07b7017fc83c2e@[207.213.214.34]>; from jlundell@pobox.com on Mon, Apr 16, 2001 at 10:07:56PM -0700
X-Operating-System: Linux tatooine.laforge.distro.conectiva 2.4.2-ac20
X-Date: Today is Setting Orange, the 37th day of Discord in the YOLD 3167
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2001 at 10:07:56PM -0700, Jonathan Lundell wrote:
> At 11:30 PM -0400 2001-04-16, Chris Kloiber wrote:
> >I was recently looking for a single location where all the possible
> >module parameters for the linux kernel was located.
> 
> Hear him. A DocBook document would be a dandy place for this to get pulled
> together, too.

good idea. One could just grab all the MODULE_PARM_DESC out of all sourcefiles,
look to which module the particular sourcefile belongs (looking into
Makefile?), and create a Documentation/DocBook/... document out of it.

Sounds like something doable, only somebody needs to get around doing
it. Any volunteers?

> -- 
> /Jonathan Lundell.

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org                http://www.gnumonks.org
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M- 
V-- PS+ PE-- Y+ PGP++ t++ 5-- !X !R tv-- b+++ DI? !D G+ e* h+ r% y+(*)
