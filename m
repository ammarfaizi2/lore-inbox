Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263257AbRFIDwl>; Fri, 8 Jun 2001 23:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263746AbRFIDwb>; Fri, 8 Jun 2001 23:52:31 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:41490 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S263257AbRFIDwO>;
	Fri, 8 Jun 2001 23:52:14 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106090352.f593q7M491225@saturn.cs.uml.edu>
Subject: Re: temperature standard - global config option?
To: jcwren@jcwren.com
Date: Fri, 8 Jun 2001 23:52:07 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <NDBBKBJHGFJMEMHPOPEGMEOOCIAA.jcwren@jcwren.com> from "John Chris Wren" at Jun 08, 2001 07:53:06 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Chris Wren writes:

> coupling to the CPU that is about as bad as it can get.  You've got an epoxy
> housing of an inconsistent shape in contact with ceramic.  The actual
> contact point is miniscule.  There's no thermal paste, and often, I've seen
> the sensors not quite raised high enough to contact the chip (you should be
> able to rack a business card across the empty socket and feel a slight
> "bump" as you touch the sensor.  If not, you need to bend it up slightly, to
> give better physical contact to the CPU).
> 
> But in spite of all this, you're not really measure the critical
> temperature, which is junction tempature.  Yes, case tempature has *some*

There are processors with temperature measurement built right
into the silicon.

> For the record, in the course of a normal day, I see my temperatures
> fluctuate from 48C with the house A/C set to 73, to 56C when I open the
> doors, and let it get up to 76 in the house.  That's 8C (14.4F) over a 3F
> change in ambient.

This makes sense. Heat increases resistance, which generates heat.
At some point, a tiny increase will cause thermal run-away.

