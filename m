Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130352AbRCBI3B>; Fri, 2 Mar 2001 03:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130353AbRCBI2w>; Fri, 2 Mar 2001 03:28:52 -0500
Received: from office.globe.cz ([212.27.204.26]:15886 "HELO gw.office.globe.cz")
	by vger.kernel.org with SMTP id <S130352AbRCBI2m>;
	Fri, 2 Mar 2001 03:28:42 -0500
To: linux-kernel@vger.kernel.org
Subject: Night freezes of computer (2.4.2)
From: Ondrej Sury <sury.ondrej@globe.cz>
Date: 02 Mar 2001 09:28:34 +0100
Message-ID: <874rxcbmml.fsf@druid.office.globe.cz>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.0.98
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have Duron on Via chipset.  Kernel is 2.4.2.  When I leave my computer in
work on during night, it freezes hard.  I have X running, so there are no
messages on console.  I suspect that maybe ACPI is doing that, so I am
going to disable it and try it again.  I will also shutdown Xserver before
I will be going home today, so I can see some kernel messages (if any) on
console.  I think that it is some 2.4.2 issue, because I don't remember
similar behaviour on earlier kernels.

/var/log/messages:

Mar  2 01:24:28 druid -- MARK --
Mar  2 01:44:28 druid -- MARK --
Mar  2 09:10:56 druid syslogd 1.3-3#33.1: restart.

-- 
Ondøej Surý <ondrej@globe.cz>         Globe Internet s.r.o. http://globe.cz/
Tel: +420235365000   Fax: +420235365009         Plánièkova 1, 162 00 Praha 6
Mob: +420605204544   ICQ: 24944126             Mapa: http://globe.namape.cz/
GPG fingerprint:          CC91 8F02 8CDE 911A 933F  AE52 F4E6 6A7C C20D F273
