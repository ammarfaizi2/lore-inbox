Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262207AbSKYA2d>; Sun, 24 Nov 2002 19:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSKYA2c>; Sun, 24 Nov 2002 19:28:32 -0500
Received: from louise.pinerecords.com ([212.71.160.16]:43018 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S262207AbSKYA1X>; Sun, 24 Nov 2002 19:27:23 -0500
Date: Mon, 25 Nov 2002 01:34:26 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: "Murray J. Root" <murrayr@brain.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.49 kernel panic - cannot load root fs from 3:0a
Message-ID: <20021125003426.GE21852@louise.pinerecords.com>
References: <20021124215113.GC1597@Master.Wizards>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021124215113.GC1597@Master.Wizards>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I get the message referred to in the subject when trying to boot
> 2.5.49.
> My entire drive is reiserfs. kernel compiled with reiserfs.
> Does resierfs (v4) not work with older reiserfs?

'reiser4' is an entirely new fs.  you have to compile in 'reiserfs'
to be able to mount v3.[56] volumes.

-- 
Tomas Szepe <szepe@pinerecords.com>
