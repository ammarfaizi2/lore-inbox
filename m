Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262549AbSJGRDb>; Mon, 7 Oct 2002 13:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262555AbSJGRDb>; Mon, 7 Oct 2002 13:03:31 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:9484 "EHLO probity.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S262549AbSJGRDb>;
	Mon, 7 Oct 2002 13:03:31 -0400
Date: Mon, 7 Oct 2002 17:35:36 +0100
From: John Levon <levon@movementarian.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.40 kbuild bug: mrproper removes files it shouldn't remove
Message-ID: <20021007163536.GA14958@compsoc.man.ac.uk>
References: <200210071608.SAA03742@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210071608.SAA03742@harpo.it.uu.se>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17yar2-000Iqr-00*VIPw2Xu91E.* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 06:08:24PM +0200, Mikael Pettersson wrote:

> 'make mrproper' incorrectly deletes *~-style editor backup files

A vaguely related long time irritation :

cp .config .config-phew-saved-it
make mrproper

whoops !

regards
john

-- 
"I will eat a rubber tire to the music of The Flight of the Bumblebee"
