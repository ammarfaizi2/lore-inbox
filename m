Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267630AbRGNLnS>; Sat, 14 Jul 2001 07:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267631AbRGNLnH>; Sat, 14 Jul 2001 07:43:07 -0400
Received: from polypc17.chem.rug.nl ([129.125.25.92]:60801 "EHLO
	polypc17.chem.rug.nl") by vger.kernel.org with ESMTP
	id <S267630AbRGNLm6>; Sat, 14 Jul 2001 07:42:58 -0400
Date: Sat, 14 Jul 2001 13:42:46 +0200 (CEST)
From: "J.R. de Jong" <jdejong@chem.rug.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x swap >= 2*memsize requirement status.
Message-ID: <Pine.LNX.4.21.0107141326001.12808-100000@polypc17.chem.rug.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I noticed that among fellow linux users there is much confusion about the
2.4.x swap requirement. Some heard that it is a _requirement_ to have >=
2*memsize swap or none at all, and others heard that it is advisory in the
sense that performance/stability wil drop drastically when one does not
take this advice to heart.

There was a heated debate about the wisdom of the supposed requirement,
especially since many found it to be a major drawback compared to the
2.2.x series. However, I think there is a need for clarity on the real
status of the issue. Which brings me to my question: Can anyone shed some
light on how 'required' this requirement really is and what one could
expect to happen when this requirement is not met?

Regards,

Johan de Jong.


