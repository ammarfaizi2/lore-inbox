Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278933AbRJ2BOA>; Sun, 28 Oct 2001 20:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278932AbRJ2BNu>; Sun, 28 Oct 2001 20:13:50 -0500
Received: from due.stud.ntnu.no ([129.241.56.71]:32260 "HELO due.stud.ntnu.no")
	by vger.kernel.org with SMTP id <S278931AbRJ2BNi>;
	Sun, 28 Oct 2001 20:13:38 -0500
Date: Mon, 29 Oct 2001 02:13:39 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: linux-kernel@vger.kernel.org
Subject: Intel EEPro 100 with kernel drivers
Message-ID: <20011029021339.B23985@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

We've got a lot of machines with the eepro 100 from intel onboard, and when
we try to stress-test the network (running bonnie++ on a nfs-shared
directory on a machine), the network-card says "eth0: Card reports no
resources" to dmesg, and then the "line" appear dead for some time (one
minutte or more). What can be done to remove this error? NFS timesout with
this error (obviously)...

-- 
Thomas
