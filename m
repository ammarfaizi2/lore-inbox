Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281329AbRKEUzM>; Mon, 5 Nov 2001 15:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281332AbRKEUzC>; Mon, 5 Nov 2001 15:55:02 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:42372 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S281329AbRKEUyp>; Mon, 5 Nov 2001 15:54:45 -0500
Content-Type: text/plain; charset=US-ASCII
From: Thomas Koeller <tkoeller@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Scheduling of low-priority background processes
Date: Mon, 5 Nov 2001 21:53:38 +0100
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01110521533900.00641@sarkovy.koeller.org>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear kernel wizards,

first of all, I wish to apologize in case I am asking a questions that has already been discussed much on this list. I am not a subscriber
(so please CC. me if you respond to this mail) and by browsing the list archive I did not immediatly find any discussion about my topic.
So here is my question:

Some operating systems I have been working with had a scheduling policy different from what I find in Linux.
