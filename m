Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132512AbRDWWoM>; Mon, 23 Apr 2001 18:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132513AbRDWWnz>; Mon, 23 Apr 2001 18:43:55 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:63243 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S132500AbRDWWnc>;
	Mon, 23 Apr 2001 18:43:32 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104232242.f3NMgej516228@saturn.cs.uml.edu>
Subject: Re: hundreds of mount --bind mountpoints?
To: rgooch@ras.ucalgary.ca (Richard Gooch)
Date: Mon, 23 Apr 2001 18:42:40 -0400 (EDT)
Cc: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser),
        viro@math.psu.edu (Alexander Viro), cr@sap.com (Christoph Rohland),
        parsley@linuxjedi.org (David L. Parsley), linux-kernel@vger.kernel.org
In-Reply-To: <200104232119.f3NLJZT24922@vindaloo.ras.ucalgary.ca> from "Richard Gooch" at Apr 23, 2001 03:19:35 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch writes:

> We want to take out that union because it sucks for virtual
> filesystems. Besides, it's ugly.

I hope you won't mind if people trash this with benchmarks.

