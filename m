Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268321AbTCCEMp>; Sun, 2 Mar 2003 23:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268322AbTCCEMp>; Sun, 2 Mar 2003 23:12:45 -0500
Received: from visp12-175.visp.co.nz ([210.54.175.12]:2829 "EHLO
	mdew.dyndns.org") by vger.kernel.org with ESMTP id <S268321AbTCCEMi>;
	Sun, 2 Mar 2003 23:12:38 -0500
Subject: Fwd: Stv0680-usb-general] USB error?
From: mdew <mdew@mdew.dyndns.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-ghwHuWIHD8+aWF7xBU+H"
Organization: 
Message-Id: <1046665376.15584.29.camel@nirvana.flat>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 03 Mar 2003 17:22:56 +1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ghwHuWIHD8+aWF7xBU+H
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


-- 
mdew <mdew@mdew.dyndns.org>

--=-ghwHuWIHD8+aWF7xBU+H
Content-Disposition: inline
Content-Description: Forwarded message - [Stv0680-usb-general] USB error?
Content-Type: message/rfc822

Return-Path: <stv0680-usb-general-admin@lists.sourceforge.net>
X-Original-To: mdew@mdew.dyndns.org
Delivered-To: mdew@mdew.dyndns.org
Received: from sc8-sf-list2.sourceforge.net (lists.sourceforge.net
	[66.35.250.206]) by mdew.dyndns.org (Postfix) with ESMTP id EC4E3A82CF for
	<mdew@mdew.dyndns.org>; Mon,  3 Mar 2003 15:12:29 +1300 (NZDT)
Received: from sc8-sf-list1-b.sourceforge.net ([10.3.1.13]
	helo=sc8-sf-list1.sourceforge.net) by sc8-sf-list2.sourceforge.net with
	esmtp (Exim 3.31-VA-mm2 #1 (Debian)) id 18pfRM-0004Uy-00; Sun, 02 Mar 2003
	18:12:28 -0800
Received: from visp12-175.visp.co.nz ([210.54.175.12] helo=mdew.dyndns.org
	ident=foobar) by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2
	#1 (Debian)) id 18pfPF-0000dF-00 for
	<stv0680-usb-general@lists.sourceforge.net>; Sun, 02 Mar 2003 18:10:18 -0800
Received: from [10.0.0.3] (mdew.mdew.dyndns.org [10.0.0.3]) by
	mdew.dyndns.org (Postfix) with ESMTP id 13380A82CF for
	<stv0680-usb-general@lists.sourceforge.net>; Mon,  3 Mar 2003 15:09:54
	+1300 (NZDT)
From: mdew <mdew@mdew.dyndns.org>
To: stv0680-usb <stv0680-usb-general@lists.sourceforge.net>
Content-Type: text/plain
Organization: 
Message-Id: <1046657391.16334.26.camel@nirvana.flat>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Subject: [Stv0680-usb-general] USB error?
Sender: stv0680-usb-general-admin@lists.sourceforge.net
Errors-To: stv0680-usb-general-admin@lists.sourceforge.net
X-BeenThere: stv0680-usb-general@lists.sourceforge.net
X-Mailman-Version: 2.0.9-sf.net
Precedence: bulk
List-Help: 	<mailto:stv0680-usb-general-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:stv0680-usb-general@lists.sourceforge.net>
List-Subscribe: 	<https://lists.sourceforge.net/lists/listinfo/stv0680-usb-general>,
	<mailto:stv0680-usb-general-request@lists.sourceforge.net?subject=subscribe>
List-Id: General list for stv0680 based, usb cameras
	<stv0680-usb-general.lists.sourceforge.net>
List-Unsubscribe: 	<https://lists.sourceforge.net/lists/listinfo/stv0680-usb-general>,
	<mailto:stv0680-usb-general-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 	<http://sourceforge.net/mailarchive/forum.php?forum=stv0680-usb-general>
X-Original-Date: 03 Mar 2003 15:09:52 +1300
Date: 03 Mar 2003 15:09:52 +1300
X-UIDL: :hH!!8e9"!CbS"!TkO!!
Content-Transfer-Encoding: 7bit

nirvana:~/pencam2-0.65# ./pencam2
 usb_claim_interface error
 usb_claim_interface error

 *  *  *  *  *   PENCAM2 ver 0.65 for STV0680 usb cameras   *  *  *  * 
*

 STV Camera @     Camera Pictures     Firmware     ASIC rev     Sensor
ID
   001:063               2              3.00         7.60         410.10
 *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 
*
 Supported formats: CIF (352x288)    QCIF (176x144)
 *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  *  * 
*


stv680.c: [stv680_probe:1519] STV(i): STV0680 camera found.
stv680.c: [stv680_probe:1547] STV(i): registered new video device:
video1
usbdevfs: process 16500 (pencam2) did not claim interface 0 before use
usb-uhci.c: interrupt, status 3, frame# 1933
usbdevfs: USBDEVFS_CONTROL failed dev 63 rqt 192 rq 4 len 0 ret -32
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 63 rqt 192 rq 134 len 16 ret -110
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 63 rqt 192 rq 134 len 16 ret -110
usb_control/bulk_msg: timeout
usbdevfs: USBDEVFS_CONTROL failed dev 63 rqt 192 rq 134 len 16 ret -110



x = Start/stop autosnap

Enter your choice: x
 usb_bulk_read error
 usb_control_msg error: 9,  command = 0x21
 Re-initializing camera
 usb_control_msg error: 16,  command = 0x86
 Couldn't get image info
 usb_control_msg error: 16,  command = 0x86
 Couldn't get image info
 usb_control_msg error: 16,  command = 0x86
 Couldn't get image info
 Couldn't get picture after 3 tries, giving up!

nirvana:~# cat /proc/video/stv680/video1
driver_version  : v0.25
model           : STV0680
in use          : no
streaming       : no
num_frames      : 2
Current size    : 0x0
swapRGB         : (auto) off
Palette         : 0
Frames total    : 0
Frames read     : 0
Packets dropped : 0
Decoding Errors : 0

nirvana:~# cat /proc/video/dev/video1
name            : STV0680 USB camera
type            : VID_TYPE_CAPTURE
hardware        : 0x1e

nirvana:~# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
4000-403f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
5000-501f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
9000-9fff : PCI Bus #01
a000-a01f : Intel Corp. 82371AB/EB/MB PIIX4 USB
  a000-a01f : usb-uhci
a400-a43f : Yamaha Corporation YMF-744B [DS-1S Audio Controller]
  a400-a401 : OPL2/3 (left)
  a402-a403 : OPL2/3 (right)
  a420-a421 : MPU401 UART
a800-a803 : Yamaha Corporation YMF-744B [DS-1S Audio Controller]
ac00-acff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  ac00-acff : 8139too
b000-b007 : Promise Technology, Inc. 20262
  b000-b007 : ide2
b400-b403 : Promise Technology, Inc. 20262
  b402-b402 : ide2
b800-b807 : Promise Technology, Inc. 20262
bc00-bc03 : Promise Technology, Inc. 20262
c000-c03f : Promise Technology, Inc. 20262
  c000-c007 : ide2
  c008-c00f : ide3
  c010-c03f : PDC20262
f000-f00f : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  f000-f007 : ide0
  f008-f00f : ide1

nirvana:~# cat /proc/bus/usb/drivers
         usbdevfs
         hub
         hid
 48- 63: usbscanner
         usb_mouse
         stv680
         usb-storage

nirvana:# cat /proc/bus/usb/devices
T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=126/900 us (14%), #Int=  4, #Iso=  0
D:  Ver= 1.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 0.00
S:  Product=USB UHCI Root Hub
S:  SerialNumber=a000
C:* #Ifs= 1 Cfg#= 1 Atr=40 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   8 Ivl=255ms
T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=055f ProdID=0006 Rev= 1.00
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=496mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=00(>ifc ) Sub=00 Prot=00 Driver=usbscanner
E:  Ad=01(O) Atr=02(Bulk) MxPS=   2 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=83(I) Atr=03(Int.) MxPS=   1 Ivl=1ms
T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=02 Dev#=  3 Spd=12  MxCh= 4
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0000 ProdID=0e01 Rev= 0.04
S:  Product=USB HUB
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
T:  Bus=01 Lev=02 Prnt=03 Port=00 Cnt=01 Dev#= 59 Spd=12  MxCh= 4
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=03eb ProdID=3301 Rev= 3.00
S:  Product=Standard USB Hub
C:* #Ifs= 1 Cfg#= 1 Atr=e0 MxPwr= 64mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms
T:  Bus=01 Lev=03 Prnt=59 Port=00 Cnt=01 Dev#= 63 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=ff(vend.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0553 ProdID=0202 Rev= 0.00
S:  Manufacturer=STMicroelectronics
S:  Product=USB Dual-mode Camera
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr= 70mA
I:  If#= 0 Alt= 0 #EPs= 0 Cls=ff(vend.) Sub=00 Prot=00 Driver=stv680
I:  If#= 0 Alt= 1 #EPs= 1 Cls=ff(vend.) Sub=00 Prot=00 Driver=stv680
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
T:  Bus=01 Lev=03 Prnt=59 Port=01 Cnt=02 Dev#= 60 Spd=1.5 MxCh= 0
D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=09da ProdID=0006 Rev= 1.00
S:  Manufacturer=A4Tech
S:  Product=USB Optical Mouse
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=02 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   4 Ivl=10ms
T:  Bus=01 Lev=03 Prnt=59 Port=03 Cnt=03 Dev#= 61 Spd=1.5 MxCh= 0
D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0663 ProdID=0103 Rev= 1.00
C:* #Ifs= 1 Cfg#= 1 Atr=80 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=00 Driver=hid
E:  Ad=81(I) Atr=03(Int.) MxPS=   7 Ivl=10ms

nirvana:# lsmod
Module                  Size  Used by    Tainted: P
vfat                   10860   0  (autoclean)
fat                    32760   0  (autoclean) [vfat]
usb-storage            24016   0  (unused)
sd_mod                 10892   0  (autoclean) (unused)
stv680                 24696   0
parport_pc             23752   1  (autoclean)
lp                      6912   0  (autoclean)
snd-pcm-oss            37700   0  (autoclean)
snd-mixer-oss          10936   1  (autoclean) [snd-pcm-oss]
NVdriver             1061664   0  (unused)
joydev                  5920   0  (unused)
usbmouse                2296   0  (unused)
scanner                 9336   0
mousedev                4340   1
keybdev                 2144   0  (unused)
snd-ymfpci             41776   1
snd-pcm                53472   0  [snd-pcm-oss snd-ymfpci]
snd-opl3-lib            6404   0  [snd-ymfpci]
snd-timer              11080   0  [snd-pcm snd-opl3-lib]
snd-hwdep               4256   0  [snd-opl3-lib]
snd-mpu401-uart         3168   0  [snd-ymfpci]
snd-rawmidi            13696   0  [snd-mpu401-uart]
snd-seq-device          4156   0  [snd-opl3-lib snd-rawmidi]
snd-ac97-codec         26948   0  [snd-ymfpci]
snd                    26308   0  [snd-pcm-oss snd-mixer-oss snd-ymfpci
snd-pcm snd-opl3-lib snd-timer snd-hwdep snd-mpu401-uart snd-rawmidi
snd-seq-device snd-ac97-codec]
usb-uhci               23340   0  (unused)
hid                    14216   0  (unused)
input                   3520   0  [joydev usbmouse mousedev keybdev hid]
ide-cd                 30532   0
loop                    9528   0  (unused)
sg                     28364   0
sr_mod                 15960   0
ide-scsi                8848   0
cdrom                  29248   0  [ide-cd sr_mod]
scsi_mod               56916   4  [usb-storage sd_mod sg sr_mod
ide-scsi]
tuner                  10240   1  (autoclean)
tvaudio                12796   0  (autoclean) (unused)
bttv                   69504   0
soundcore               3812   7  [snd bttv]
i2c-algo-bit            7656   1  [bttv]
8139too                14888   1

nirvana:# uname -a
Linux nirvana 2.4.20-xfs-rmap15d #1 Thu Feb 6 01:06:41 NZDT 2003 i686
unknown unknown GNU/Linux

-- 
mdew <mdew@mdew.dyndns.org>



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Stv0680-usb-general mailing list
Stv0680-usb-general@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/stv0680-usb-general


--=-ghwHuWIHD8+aWF7xBU+H--

