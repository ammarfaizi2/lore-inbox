Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262914AbSJLMWZ>; Sat, 12 Oct 2002 08:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262915AbSJLMWZ>; Sat, 12 Oct 2002 08:22:25 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:31898 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S262914AbSJLMWZ>; Sat, 12 Oct 2002 08:22:25 -0400
Message-ID: <20021012122804.32437.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Sat, 12 Oct 2002 20:28:04 +0800
Subject: Process Creation, 2.4.19 vs 2.5.42
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I'm playing with unixbench-4.1.0 and I got this strange results with the process creation test:

--- Process Creation ---
2.4.19     2.5.42
9119.5     5477.6       60.1

2.5.42 throughput is only the 60% of the 2.4.19 one.

Comments ?

Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
