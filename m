Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281449AbRKVSwo>; Thu, 22 Nov 2001 13:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281337AbRKVSwg>; Thu, 22 Nov 2001 13:52:36 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:43742 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S281326AbRKVSw1>;
	Thu, 22 Nov 2001 13:52:27 -0500
Date: Thu, 22 Nov 2001 18:52:24 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: What are the recommended software RAID patch(es) for 2.2.20?
Message-ID: <2173081930.1006455144@[195.224.237.69]>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What are the recommended software RAID patch(es) for 2.2.20.

I have applied, but not yet tested, raid-2.2.19-A1, which
fails on one hunk in init.c which I think is unimportant
(seemingly 2.2.20 has a full boot line to device translation
table without conditionality of compilation).

Do I need to apply anything else? (-A2, -A3, -B1, -B2 or
whatever) in which case where do I get them from? (not
kernel.org/people/mingo or wherever, apparently).

--
Alex Bligh
