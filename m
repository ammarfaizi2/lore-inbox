Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbTLWTGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 14:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262331AbTLWTGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 14:06:23 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:8064 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262308AbTLWTGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 14:06:22 -0500
Date: Tue, 23 Dec 2003 19:12:31 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200312231912.hBNJCVx5000438@81-2-122-30.bradfords.org.uk>
To: Gene Heskett <gene.heskett@verizon.net>, <xan2@ono.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200312231207.53580.gene.heskett@verizon.net>
References: <178ed117d672.17d672178ed1@ono.com>
 <200312231207.53580.gene.heskett@verizon.net>
Subject: Remove superflous copy of logo in /Documentation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patent expired earlier this year.

Not in all patent-encumbered territories.

Since we already have copies of the logo in ppm format in
/drivers/video/logo/, why not simply delete the copy in
/Documentation?

Also, we should really have an ASCII logo for serial consoles...

John.
