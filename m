Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281088AbRKPFIc>; Fri, 16 Nov 2001 00:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281102AbRKPFIV>; Fri, 16 Nov 2001 00:08:21 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:13819
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281088AbRKPFID>; Fri, 16 Nov 2001 00:08:03 -0500
Date: Thu, 15 Nov 2001 21:07:57 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.15-pre5 Changelog
Message-ID: <20011115210757.A21354@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here you go:

pre5:
 - Greg KH: enable hotplug driver support
 - Andrea Arcangeli: remove bogus sanity check
 - David Mosberger: /proc/cpuinfo and scsi scatter-gather for ia64
 - David Hinds: 16-bit pcmcia network driver updates/cleanups
 - Hugh Dickins: remove some stale code from VM
 - David Miller: /proc/cpuinfo for sparc, sparc fork bug fix, network
   fixes, warning fixes
 - Peter Braam: intermezzo update
 - Greg KH: USB updates
 - Ivan Kokshaysky: /proc/cpuinfo for alpha
 - David Woodhouse: jffs2 - remove dead code, remove gcc3 warning
 - Hugh Dickins: fix kiobuf page allocation/deallocation

pre4:
 - Mikael Pettersson: make proc_misc happy without modules
 - Arjan van de Ven: clean up acpitable implementation ("micro-acpi")
 - Anton Altaparmakov: LDM partition code update
 - Alan Cox: final (yeah, sure) small missing pieces
 - Andrey Savochkin/Andrew Morton: eepro100 config space save/restore over suspend
 - Arjan van de Ven: remove power from pcmcia socket on card remove
 - Greg KH: USB updates
 - Neil Brown: multipath updates
 - Martin Dalecki: fix up some "asmlinkage" routine markings

pre3:
 - Alan Cox: more driver merging
 - Al Viro: make ext2 group allocation more readable

pre2:
 - Ivan Kokshaysky: fix alpha dec_and_lock with modules, for alpha config entry
 - Kai Germaschewski: ISDN updates
 - Jeff Garzik: network driver updates, sysv fs update
 - Kai Mäkisara: SCSI tape update
 - Alan Cox: large drivers merge
 - Nikita Danilov: reiserfs procfs information
 - Andrew Morton: ext3 merge
 - Christoph Hellwig: vxfs livelock fix
 - Trond Myklebust: NFS updates
 - Jens Axboe: cpqarray + cciss dequeue fix
 - Tim Waugh: parport_serial base_baud setting
 - Matthew Dharm: usb-storage Freecom driver fixes
 - Dave McCracken: wait4() thread group race fix

pre1:
 - me: fix page flags race condition Andrea found
 - David Miller: sparc and network updates
 - various: fix loop driver that thought it was part of the VM system
 - me: teach DRM about VM_RESERVED
 - Alan Cox: more merging
