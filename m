Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263630AbRFARed>; Fri, 1 Jun 2001 13:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263632AbRFAReY>; Fri, 1 Jun 2001 13:34:24 -0400
Received: from hera.cwi.nl ([192.16.191.8]:16871 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263630AbRFAReC>;
	Fri, 1 Jun 2001 13:34:02 -0400
Date: Fri, 1 Jun 2001 19:33:53 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106011733.TAA179526.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, lost@l-w.net
Subject: Re: select() - Linux vs. BSD
Cc: dean-list-linux-kernel@arctic.org, jcwren@jcwren.com,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So how does this say the value of the fdsets are undefined
> after a timeout?

You are right, it doesn't say so. I should have said
  That is, a wise programmer does not assume any particular value
  for the bits after an error.

Andries
