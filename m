Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbTKLIjD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 03:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbTKLIjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 03:39:03 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:49354
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261842AbTKLIjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 03:39:01 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: mzyngier@freesurf.fr
Subject: Re: Why can't I shut scsi device support off in -test9?
Date: Wed, 12 Nov 2003 02:35:40 -0600
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200311120046.04348.rob@landley.net> <200311120203.51599.rob@landley.net> <wrpu15a6lsq.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <wrpu15a6lsq.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311120235.40639.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 November 2003 02:19, Marc Zyngier wrote:
> Odd...
>
> I simply put your .config in my test9-latest tree, removed
> CONFIG_SCSI with 'make menuconfig', and it simply went away...
>
> Maybe someone fixed this behaviour in test9-latest ?
>
> 	M.

I'll try it again if -test10 ever comes out...

Rob
