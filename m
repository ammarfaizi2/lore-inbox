Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265787AbUFDOSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265787AbUFDOSZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 10:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUFDOSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 10:18:25 -0400
Received: from hosted-by.rockingstone.nl ([213.206.77.161]:35033 "EHLO
	web1.rockingstone.nl") by vger.kernel.org with ESMTP
	id S265787AbUFDOSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 10:18:07 -0400
Date: Fri, 4 Jun 2004 16:18:04 +0200
From: Rick Jansen <rick@rockingstone.nl>
To: John Bradford <john@grabjohn.com>
Cc: Daniel Egger <de@axiros.com>, linux-kernel@vger.kernel.org
Subject: Re: DriveReady SeekComplete Error
Message-ID: <20040604141804.GF1684@web1.rockingstone.nl>
References: <20040604075448.GK18885@web1.rockingstone.nl> <200406040943.i549h2aG000175@81-2-122-30.bradfords.org.uk> <20040604095409.GL18885@web1.rockingstone.nl> <E0E7D4BA-B62C-11D8-B781-000A958E35DC@axiros.com> <20040604135326.GD1684@web1.rockingstone.nl> <200406041405.i54E5Kc4000144@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
In-Reply-To: <200406041405.i54E5Kc4000144@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.2.1i
X-Sysadmin-was-here: Rick Jansen (Rockingstone IT)
X-PGP-Key: http://www.rockingstone.nl/rick/pubkey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 04, 2004 at 03:05:20PM +0100, John Bradford wrote:
> Send all the data.
>=20
> John.

smartctl version 5.30 Copyright (C) 2002-4 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

=3D=3D=3D START OF INFORMATION SECTION =3D=3D=3D
Device Model:     Maxtor 6Y120P0
Serial Number:    Y43XXY5E
Firmware Version: YAR41BW0
Device is:        In smartctl database [for details use: -P show]
ATA Version is:   7
ATA Standard is:  ATA/ATAPI-7 T13 1532D revision 0
Local Time is:    Fri Jun  4 16:16:57 2004 CEST
SMART support is: Available - device has SMART capability.
SMART support is: Enabled

=3D=3D=3D START OF READ SMART DATA SECTION =3D=3D=3D
SMART overall-health self-assessment test result: PASSED

General SMART Values:
Offline data collection status:  (0x80)	Offline data collection activity was
					never started.
					Auto Offline Data Collection: Enabled.
Self-test execution status:      ( 118)	The previous self-test completed ha=
ving
					the read element of the test failed.
Total time to complete Offline=20
data collection: 		 ( 182) seconds.
Offline data collection
capabilities: 			 (0x5b) SMART execute Offline immediate.
					Auto Offline data collection on/off support.
					Suspend Offline collection upon new
					command.
					Offline surface scan supported.
					Self-test supported.
					No Conveyance Self-test supported.
					Selective Self-test supported.
SMART capabilities:            (0x0003)	Saves SMART data before entering
					power-saving mode.
					Supports SMART auto save timer.
Error logging capability:        (0x01)	Error logging supported.
					No General Purpose Logging support.
Short self-test routine=20
recommended polling time: 	 (   2) minutes.
Extended self-test routine
recommended polling time: 	 (  60) minutes.

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  =
WHEN_FAILED RAW_VALUE
  3 Spin_Up_Time            0x0027   252   252   063    Pre-fail  Always   =
    -       1249
  4 Start_Stop_Count        0x0032   253   253   000    Old_age   Always   =
    -       6
  5 Reallocated_Sector_Ct   0x0033   252   252   063    Pre-fail  Always   =
    -       15
  6 Read_Channel_Margin     0x0001   253   253   100    Pre-fail  Offline  =
    -       0
  7 Seek_Error_Rate         0x000a   253   252   000    Old_age   Always   =
    -       0
  8 Seek_Time_Performance   0x0027   249   244   187    Pre-fail  Always   =
    -       41816
  9 Power_On_Minutes        0x0032   251   251   000    Old_age   Always   =
    -       908h+44m
 10 Spin_Retry_Count        0x002b   252   252   157    Pre-fail  Always   =
    -       0
 11 Calibration_Retry_Count 0x002b   252   252   223    Pre-fail  Always   =
    -       0
 12 Power_Cycle_Count       0x0032   253   253   000    Old_age   Always   =
    -       8
192 Power-Off_Retract_Count 0x0032   253   253   000    Old_age   Always   =
    -       0
193 Load_Cycle_Count        0x0032   253   253   000    Old_age   Always   =
    -       0
194 Temperature_Celsius     0x0032   253   253   000    Old_age   Always   =
    -       38
195 Hardware_ECC_Recovered  0x000a   253   252   000    Old_age   Always   =
    -       1632
196 Reallocated_Event_Count 0x0008   253   253   000    Old_age   Offline  =
    -       0
197 Current_Pending_Sector  0x0008   252   252   000    Old_age   Offline  =
    -       13
198 Offline_Uncorrectable   0x0008   252   252   000    Old_age   Offline  =
    -       1
199 UDMA_CRC_Error_Count    0x0008   199   199   000    Old_age   Offline  =
    -       0
200 Multi_Zone_Error_Rate   0x000a   253   252   000    Old_age   Always   =
    -       0
201 Soft_Read_Error_Rate    0x000a   253   252   000    Old_age   Always   =
    -       5
202 TA_Increase_Count       0x000a   253   252   000    Old_age   Always   =
    -       0
203 Run_Out_Cancel          0x000b   253   252   180    Pre-fail  Always   =
    -       0
204 Shock_Count_Write_Opern 0x000a   253   252   000    Old_age   Always   =
    -       0
205 Shock_Rate_Write_Opern  0x000a   253   252   000    Old_age   Always   =
    -       0
207 Spin_High_Current       0x002a   252   252   000    Old_age   Always   =
    -       0
208 Spin_Buzz               0x002a   252   252   000    Old_age   Always   =
    -       0
209 Offline_Seek_Performnce 0x0024   195   195   000    Old_age   Offline  =
    -       0
 99 Unknown_Attribute       0x0004   253   253   000    Old_age   Offline  =
    -       0
100 Unknown_Attribute       0x0004   253   253   000    Old_age   Offline  =
    -       0
101 Unknown_Attribute       0x0004   253   253   000    Old_age   Offline  =
    -       0

SMART Error Log Version: 1
ATA Error Count: 440 (device log contains only the most recent five errors)
	CR =3D Command Register [HEX]
	FR =3D Features Register [HEX]
	SC =3D Sector Count Register [HEX]
	SN =3D Sector Number Register [HEX]
	CL =3D Cylinder Low Register [HEX]
	CH =3D Cylinder High Register [HEX]
	DH =3D Device/Head Register [HEX]
	DC =3D Device Command Register [HEX]
	ER =3D Error register [HEX]
	ST =3D Status register [HEX]
Timestamp =3D decimal seconds since the previous disk power-on.
Note: timestamp "wraps" after 2^32 msec =3D 49.710 days.

Error 440 occurred at disk power-on lifetime: 843 hours
  When the command that caused the error occurred, the device was in an unk=
nown state.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 03 77 dd 8b ed  Error: UNC 3 sectors at LBA =3D 0x0d8bdd77 =3D 2272=
70007

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Timestamp  Command/Feature_Name
  -- -- -- -- -- -- -- --   ---------  --------------------
  c8 00 08 77 dd 8b ed 08 2045545.712  READ DMA
  ca 00 08 e8 a1 3c e0 08 2045545.680  WRITE DMA
  ca 00 08 37 41 54 e2 08 2045545.680  WRITE DMA
  ca 00 08 d0 ca 95 e0 08 2045545.680  WRITE DMA
  ca 00 70 78 a1 3c e0 08 2045545.680  WRITE DMA

Error 439 occurred at disk power-on lifetime: 843 hours
  When the command that caused the error occurred, the device was in an unk=
nown state.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 03 77 dd 8b ed  Error: UNC 3 sectors at LBA =3D 0x0d8bdd77 =3D 2272=
70007

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Timestamp  Command/Feature_Name
  -- -- -- -- -- -- -- --   ---------  --------------------
  c8 00 08 77 dd 8b ed 08 2045544.688  READ DMA
  c8 00 40 ff 0b c7 e2 08 2045544.656  READ DMA
  c8 00 08 4f df 8b ed 08 2045543.632  READ DMA
  ca 00 08 17 0f a8 e2 08 2045543.584  WRITE DMA
  ca 00 08 ef ba 97 e2 08 2045543.584  WRITE DMA

Error 438 occurred at disk power-on lifetime: 843 hours
  When the command that caused the error occurred, the device was in an unk=
nown state.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 04 4f df 8b ed  Error: UNC 4 sectors at LBA =3D 0x0d8bdf4f =3D 2272=
70479

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Timestamp  Command/Feature_Name
  -- -- -- -- -- -- -- --   ---------  --------------------
  c8 00 08 4f df 8b ed 08 2045543.632  READ DMA
  ca 00 08 17 0f a8 e2 08 2045543.584  WRITE DMA
  ca 00 08 ef ba 97 e2 08 2045543.584  WRITE DMA
  ca 00 10 d7 ba 97 e2 08 2045543.584  WRITE DMA
  ca 00 10 8f ba 97 e2 08 2045543.584  WRITE DMA

Error 437 occurred at disk power-on lifetime: 843 hours
  When the command that caused the error occurred, the device was in an unk=
nown state.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 04 4f df 8b ed  Error: UNC 4 sectors at LBA =3D 0x0d8bdf4f =3D 2272=
70479

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Timestamp  Command/Feature_Name
  -- -- -- -- -- -- -- --   ---------  --------------------
  c8 00 08 4f df 8b ed 08 2045542.560  READ DMA
  c8 00 08 8f 0b c7 e2 08 2045542.560  READ DMA
  c8 00 50 af 0b c7 e2 08 2045542.560  READ DMA
  c8 00 10 9f 0b c7 e2 08 2045542.560  READ DMA
  c8 00 08 97 0b c7 e2 08 2045542.560  READ DMA

Error 436 occurred at disk power-on lifetime: 843 hours
  When the command that caused the error occurred, the device was in an unk=
nown state.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  40 51 03 77 dd 8b ed  Error: UNC 3 sectors at LBA =3D 0x0d8bdd77 =3D 2272=
70007

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Timestamp  Command/Feature_Name
  -- -- -- -- -- -- -- --   ---------  --------------------
  c8 00 08 77 dd 8b ed 08 2043137.264  READ DMA
  c8 00 18 f7 36 7c e3 08 2043137.248  READ DMA
  c8 00 10 3f 0f 7c e3 08 2043137.248  READ DMA
  c8 00 10 57 d5 7b e3 08 2043137.248  READ DMA
  c8 00 08 37 c7 7b e3 08 2043137.232  READ DMA

SMART Self-test log structure revision number 1
Num  Test_Description    Status                  Remaining  LifeTime(hours)=
  LBA_of_first_error
# 1  Short offline       Completed: read failure       60%       839       =
  0x0d8bdd7c
# 2  Short offline       Completed: read failure       60%       816       =
  0x0d8bdd7c
# 3  Short offline       Completed: read failure       60%       805       =
  0x0d8bdd7c

--=20
Looking for books? Try http://www.megabooksearch.com
The Linux on 64-Bit platforms Wiki: http://www.linux64.net
PGP Public Key: http://www.rockingstone.nl/rick/pubkey.asc

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAwIScQEtQzfDcRKoRAsMhAJ9DKPkCQEYqutGJLaHuRNclZIerngCfeVZL
iMoMixGx7UO4BOSjCzpx730=
=RAZR
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
