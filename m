Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbSKYHKM>; Mon, 25 Nov 2002 02:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbSKYHKM>; Mon, 25 Nov 2002 02:10:12 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:10652
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262580AbSKYHKL>; Mon, 25 Nov 2002 02:10:11 -0500
Date: Mon, 25 Nov 2002 02:20:55 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Murray J. Root" <murrayr@brain.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: keyboard and mouse lost in X
In-Reply-To: <20021125070418.GB1628@Master.Wizards>
Message-ID: <Pine.LNX.4.50.0211250217110.1462-100000@montezuma.mastecende.com>
References: <20021125070418.GB1628@Master.Wizards>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2002, Murray J. Root wrote:

> Mandrake's 2.4.20-0.3mdk kernel doesn't have this problem, and it is
> based on 2.4.20-rc2. So - where would I start looking for the possible
> differences that could be causing it in the 2.4.20-rc2/rc3? Mandrake
> adds too many patches for me to just shoot in the dark.

Try and backtrack from a working kernel till you find a kernel which
doesn't work. Then you can check the diff between the non working and the
last working kernel

Good luck,
	Zwane
-- 
function.linuxpower.ca
