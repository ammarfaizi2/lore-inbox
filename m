Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132385AbRDFUBK>; Fri, 6 Apr 2001 16:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132389AbRDFUBB>; Fri, 6 Apr 2001 16:01:01 -0400
Received: from mx.interplus.ro ([193.231.252.3]:6662 "EHLO mx.interplus.ro")
	by vger.kernel.org with ESMTP id <S132385AbRDFUAs>;
	Fri, 6 Apr 2001 16:00:48 -0400
Message-ID: <3ACE2095.BE3A4E6D@interplus.ro>
Date: Fri, 06 Apr 2001 23:01:25 +0300
From: Mircea Ciocan <mirceac@interplus.ro>
Organization: Home Office
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-ac24 i686)
X-Accept-Language: ro, en
MIME-Version: 1.0
To: lk <linux-kernel@vger.kernel.org>
Subject: Special packet inspecting bridging
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                Hi all,

        I'd like to start a project involving a packet inspecting
Ethernet
bridge/firewall/traffic shaper that is protocol independent ( I mean no
ties to high level protocols like TCP/IP or IPX for ex.).
        What I want to do is get raw Ethernet packets from one
interface, pipe
it trough an user level program and then inject it in the other one, and
viceversa, of course ;).
        Please advise me of the means of doing this with minimum
overhead
possible, or if someone started a similar project please let me know.

                        Thank you,

                        Mircea C.
