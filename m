Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbVCaD7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbVCaD7z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 22:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVCaD7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 22:59:34 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21419 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262499AbVCaD7Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 22:59:16 -0500
Date: Wed, 30 Mar 2005 22:58:59 -0500
From: Dave Jones <davej@redhat.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: sean <seandarcy2@gmail.com>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: BK snapshots removed from kernel.org?
Message-ID: <20050331035859.GA23124@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, sean <seandarcy2@gmail.com>,
	linux-kernel@vger.kernel.org, jgarzik@pobox.com
References: <200503271414.33415.nbensa@gmx.net> <20050327210218.GA1236@ip68-4-98-123.oc.oc.cox.net> <200503281226.48146.nbensa@gmx.net> <4248258A.1060604@osdl.org> <d2fr2e$lvo$1@sea.gmane.org> <424B72CC.8030801@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424B72CC.8030801@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2005 at 07:47:24PM -0800, Randy.Dunlap wrote:
 > sean wrote:
 > >Randy.Dunlap wrote:
 > >
 > >>
 > >>Did you look in
 > >>http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/old/ ?
 > >>
 > >
 > >Yes I did.
 > >
 > >Latest is 2.6.12-rc1-bk2, March 26.
 > >
 > >None since then?
 > 
 > I can't explain it other than "the snapshots are broken."
 > All I do is look around for them, and behold, just look in
 > 
 > http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/
 > 
 > for the 2.6.11.6-bk snapshots.

This madness ensues each time Linus pulls GregKH's tree
into his. The script stops snapshotting against Linus'
tree, and opts to produce -bk's against GregKH's for
some bizarre reason.

		Dave

