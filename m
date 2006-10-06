Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWJFIyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWJFIyG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 04:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWJFIyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 04:54:06 -0400
Received: from smtp.seznam.cz ([212.80.76.43]:38350 "HELO smtp.seznam.cz")
	by vger.kernel.org with SMTP id S1751352AbWJFIyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 04:54:03 -0400
X-Seznam-User: dufkaf@seznam.cz
Message-ID: <452619A3.5030605@seznam.cz>
Date: Fri, 06 Oct 2006 10:53:55 +0200
From: Frantisek Dufka <dufkaf@seznam.cz>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Pierre Ossman <drzeus-list@drzeus.cx>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 2/2] mmc: Read mmc v4 EXT_CSD
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Ossman wrote:
 >
 >Goodie. Have these patches seen any wide spread testing?

Several people tried in on Nokia N770. So far there were no error 
reports and some successful ones. Speed selection (52 vs 26Mhz) seems to 
work fine.

Succesful report examples:
http://www.gossamer-threads.com/lists/maemo/developers/11613#11613
http://www.gossamer-threads.com/lists/maemo/developers/11573#11573

I wouldn't call it widespread testing but it definitely works for some 
people.

Frantisek
