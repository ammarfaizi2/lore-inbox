Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVFPSE5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVFPSE5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 14:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVFPSE5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 14:04:57 -0400
Received: from mailfe07.tele2.fr ([212.247.154.204]:53727 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261784AbVFPSEz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 14:04:55 -0400
X-T2-Posting-ID: fwYE2n3kOu2a2MxNw+Px5b8dNnayL1jBlnNrEWBDqoU=
Date: Thu, 16 Jun 2005 19:32:51 +0200
From: Frederik Deweerdt <dev.deweerdt@laposte.net>
To: Torsten Foertsch <torsten.foertsch@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to mount a webdav filesystem?
Message-ID: <20050616173251.GC8878@gilgamesh.home.res>
Mail-Followup-To: Torsten Foertsch <torsten.foertsch@gmx.net>,
	linux-kernel@vger.kernel.org
References: <200506161837.00366.torsten.foertsch@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <200506161837.00366.torsten.foertsch@gmx.net>
User-Agent: Mutt/1.5.6i
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16/06/05 18:36 +0200, Torsten Foertsch écrivit:
> is it possible to mount a webdav filesystem on modern kernels? I know of 
> davfs2 and have used it with 2.4 but it doesn't compile anymore.
There's fusedav: http://0pointer.de/lennart/projects/fusedav/ I didn't
try it though.

Frederik Deweerdt
-- 
o---------------------------------------------o
| http://open-news.net : l'info alternative   |
| Tech - Sciences - Politique - International |
o---------------------------------------------o
