Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263035AbTCWL4b>; Sun, 23 Mar 2003 06:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263036AbTCWL4b>; Sun, 23 Mar 2003 06:56:31 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:5383 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S263035AbTCWL4a>; Sun, 23 Mar 2003 06:56:30 -0500
Date: Sun, 23 Mar 2003 13:09:49 +0100
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz
Subject: Re: 2.6.65 + matrox framebuffer: life is good!
Message-ID: <20030323120949.GA5002@hh.idb.hist.no>
References: <20030321184337.GA1837@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030321184337.GA1837@middle.of.nowhere>
User-Agent: Mutt/1.5.3i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 07:43:37PM +0100, Jurriaan wrote:
> Just to let people know there's a new version of Petr's ongoing work
> with the matrox framebuffer available:
> 
> ftp://platan.vc.cvut.cz/pub/linux/matrox-latest/
> 
> the file is called mga-2.5.65.gz, and it works wonderfully.
> 
> As far as I know, this patch was only announced on the fbdev-developers
> mailing-list. I assume there are more matrox-users here.
> 
It applies fine to 2.5.65-mm3 too.
Is this something that could be mergerd?  The current
matrox driver don't even compile.

Helge Hafting

