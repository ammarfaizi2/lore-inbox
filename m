Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267236AbTAAOtp>; Wed, 1 Jan 2003 09:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267238AbTAAOtp>; Wed, 1 Jan 2003 09:49:45 -0500
Received: from tomts10.bellnexxia.net ([209.226.175.54]:64655 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S267236AbTAAOto>; Wed, 1 Jan 2003 09:49:44 -0500
Date: Wed, 1 Jan 2003 09:57:20 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@dell
To: John Bradford <john@grabjohn.com>
cc: szepe@pinerecords.com, <linux-kernel@vger.kernel.org>
Subject: Re: a few more "make xconfig" inconsistencies
In-Reply-To: <200301011445.h01EjK3Q000861@darkstar.example.net>
Message-ID: <Pine.LNX.4.44.0301010954540.19495-100000@dell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2003, John Bradford wrote:

> For 2.5, each subcategory can be 'collapsed', so this problem doesn't
> really occur.

there's one point i want to verify.  the design of this hierarchical
structure of kernel options is not going to simply affect
"make xconfig", is it?

i'm assuming that the way this hierarchy is designed will affect
*all* of the possible make ???config variations, right?

rday

