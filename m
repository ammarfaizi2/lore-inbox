Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLAM67>; Fri, 1 Dec 2000 07:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQLAM6t>; Fri, 1 Dec 2000 07:58:49 -0500
Received: from proxy.ovh.net ([213.244.20.42]:36616 "HELO proxy.ovh.net")
	by vger.kernel.org with SMTP id <S129183AbQLAM6g>;
	Fri, 1 Dec 2000 07:58:36 -0500
Message-ID: <3A279952.BD684AD9@ovh.net>
Date: Fri, 01 Dec 2000 13:28:02 +0100
From: octave klaba <oles@ovh.net>
X-Mailer: Mozilla 4.73 [en] (Win98; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: watchdog software
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
We have a problem on a 2.2.17: sometimes it crashs
without any reason (no high load), there is no kernel panic,
the screan is black. We setup watchdog software and
we realized watchdog can not reboot this box whe it crashs
(on the others servers it works fine).

my question is:
what kind of problem can have this serveur:
hardware or software ?

Thanks for help
Octave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
