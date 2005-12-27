Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVL0Cw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVL0Cw0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 21:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbVL0Cw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 21:52:26 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:45278 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932197AbVL0CwZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 21:52:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MmhydANPoN9O0jFi6OScha4dXODlsy2rJPDjJjOqK+esQkUw8WWVv98XnddIk88uriIH2fAONRzzo7LyvXIkyEb//Klm9RwVbpXD3UGmnxbAGdyH+rMQzkwFAVZaacgSbqkQQ1y8oNHtXS/k7SpJ5InXRuqs7iG0uOE+95eD21g=
Message-ID: <71a51c440512261852u593a2795y@mail.gmail.com>
Date: Tue, 27 Dec 2005 10:52:25 +0800
From: "Legend W." <mrwangxc@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Machine Check Exception !
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I get the following message under 2.4.21 from RedHat:

CPU 3: Machine Check Exception: 0000000000000004
<Bank 0: b20000001040080f

and the box is dead.

When i use parsemce, it said:
Status: (4) Machine Check in progress.
Restart IP invalid.
parsebank(0): b20000001040080f @ 3
        External tag parity error
        CPU state corrupt. Restart not possible
        Error enabled in control register
        Error not corrected.
        Bus and interconnect error
        Participation: Local processor originated request
        Timeout: Request did not timeout
        Request: Generic error
        Transaction type : Invalid
        Memory/IO : Other

Can anybody please enlighten me what this means or what a possible
problem behind might be?

Thank you in advance

PS: my box has dual Xeon 2.8G CPU
