Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284694AbSABVso>; Wed, 2 Jan 2002 16:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284538AbSABVse>; Wed, 2 Jan 2002 16:48:34 -0500
Received: from ns.suse.de ([213.95.15.193]:5898 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284694AbSABVs3>;
	Wed, 2 Jan 2002 16:48:29 -0500
Date: Wed, 2 Jan 2002 22:48:28 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102163043.A16513@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201022247470.427-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002, Eric S. Raymond wrote:

> Consider the lives of people administering large server farms or clusters.
> Their hardware is not necessarily homogenous, and the ability to query the DMI
> tables on the fly could be useful both for administration and automatic
> process migration.

Given that 'dmidecode' works fine in those circumstances, that's still
not a convincing argument imo.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

