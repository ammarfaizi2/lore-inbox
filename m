Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161159AbWI1OoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159AbWI1OoS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 10:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161161AbWI1OoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 10:44:18 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:62895 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1161159AbWI1OoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 10:44:17 -0400
Date: Thu, 28 Sep 2006 16:41:07 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
       holzheu@de.ibm.com
Subject: Re: [S390] hypfs sparse warnings.
Message-ID: <20060928144107.GB21814@wohnheim.fh-wedel.de>
References: <20060928130737.GB1120@skybase> <20060928132540.GA18933@wohnheim.fh-wedel.de> <20060928134247.GB6899@osiris.boeblingen.de.ibm.com> <20060928135406.GB18933@wohnheim.fh-wedel.de> <20060928142139.GC6899@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060928142139.GC6899@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 September 2006 16:21:39 +0200, Heiko Carstens wrote:
> 
> You probably need to update your git tree. All of them have casts in the
> meantime. Except for the one addressed with this patch.
> See: 331c982d4a6b43cdc0d056956a1cae8a7d6237bf

Doh!

Jörn

-- 
He who knows that enough is enough will always have enough.
-- Lao Tsu
