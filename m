Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264158AbTCXLcI>; Mon, 24 Mar 2003 06:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264162AbTCXLcI>; Mon, 24 Mar 2003 06:32:08 -0500
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:39602 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S264158AbTCXLcH>; Mon, 24 Mar 2003 06:32:07 -0500
Message-ID: <20030324114308.30965.qmail@indiainfo.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Cigol C" <linuxppp@indiainfo.com>
To: linux-serial@vger.kernel.org, linux-ppp@vger.kernel.org
Cc: redhat-ppp-list@redhat.com, linux-kernel@vger.kernel.org
Date: Mon, 24 Mar 2003 17:13:07 +0530
Subject: RS485 communication
X-Originating-Ip: 203.197.138.194
X-Originating-Server: ws5-7.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
Regarding RS485 communication I thank all of them for their responses. I finally decided to write a custom Layer 2 char driver or protocol to pave way for my IP over RS485 communication. I will like to get some inputs/docs/references on linux-ppp implementation. ISo am in the process of browsing the PPP code and exploring the interface it has with the serial driver which is crucial for me. Regarding this I request for more clarity on following: 
i) Linux PPP interface with IP: Registration, Packet send/receive/close
ii) Linux PPP interface with serial driver:Registration, Packet send/receive/close
iii) Linux PPP server configuration and initial sequence of working. i.e. associating a IP address with serial device and ppp0

I will be grateful if somebody could help me on this.
Thanks and Best Regards
Karthik
-- 
______________________________________________
http://www.indiainfo.com
Now with POP3/SMTP access for only US$14.95/yr

Powered by Outblaze
