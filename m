Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSF2S0I>; Sat, 29 Jun 2002 14:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314080AbSF2S0H>; Sat, 29 Jun 2002 14:26:07 -0400
Received: from 213-97-184-209.uc.nombres.ttd.es ([213.97.184.209]:49288 "HELO
	piraos.com") by vger.kernel.org with SMTP id <S314077AbSF2S0G>;
	Sat, 29 Jun 2002 14:26:06 -0400
Date: Sat, 29 Jun 2002 20:28:08 +0200
From: German Gomez Garcia <german@piraos.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Logitech Wingman RumblePad and HID
Message-ID: <20020629182808.GA3966@piraos.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

	Hello,

	I would like to know if there is support in the kernel (I'm
using 2.4.19-10-ac2) for the Logitech Wingman RumblePad USB gamepad.
If I plug it into the USB port I get HID information (attached). If you
want me to test something (newer versions anywhere??) just ask.
	Currently it isn't working, or at least I'm not able to make
jstest or jscal working (after loading joydev), all I get when running
the jscal and the jstest is attached also. The problem with both
programs is that they totally ignore any movement or pusing of a button
in the gamepad.

	Regards,

	- german

PS: Please CC to me as I'm not subscribed to the LIST :-)

-- 
Send email with "SEND GPG KEY" as subject to receive my GnuPG public key.

--SUOF0GtieIMvvwua
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="hid.log.gz"
Content-Transfer-Encoding: base64

H4sICGL6HT0AA2hpZC5sb2cAzZffc5pAEMff+1fsI5lRe4eAyFvT9IdtmmY09lcmDycselME
CkfS5K/vHiRGCVjiQ6eOczq7e9+7/eyxp1Dki4HvQYZLmSvMMIAYbyDI5DVmsJJBgNfwAv4W
RSE09v0kQx33fnICaZYsEHwRRRQdJhnIMC7WwCq1frLypQ6dzY9hPj32LheMja6AlvPA7GHq
AetPeuo2Re/1xfS0F0ZimXsAwHoRxh57yRnv5UoojxnsqCY6fXPxIMrN7qIkuVfWXweGe+SB
y4E5wBiYph7p7dh63I0OhBLGvSRNYhRC88bALBBcf9ejCSOyuzC2dQAvZUwHwnAwGEC1j3Zg
z8mNvTRtuxMwp7uo6e5V3fBiJS8L2PAeQBi28KoUaQ73dbTll3TLaGdUjmM9jqxH6g6Jsk64
npFZd1yiu+jQeQYuk3XAVSnSHLOEa28hcvARmhWU3/nGvoNr+8nNi8VaKhkvwVdZBEW22MOz
U+ruPU93J+/tNZVcY1IouBHVyrpZlKvTp7b/KrBAUAn4EYqstp/52enk7GO1pWBkugdsqc+5
bYTlyw3qm9tg0KFFDn1O9cjQR2p99baH61TdkjNNMtWSo4wpRxHJO51oFZlTKL1fpWkkfaFk
EhvvMMZM+ieY/1RJOviQ3OZK+j/13gAmZ+fzi8tyvCoNAG8lRkEFtnrNc7FEw340ANQ0v7W7
vre7frS7pnftvlkkA8w2/tNkSZlG8IlorIv19sY3LvG7dOnTvXGer27ztomPvqaZ06omM3mH
9IjVza+TIlbG0/DPYZij2l7lrT5CBnwRmRSLCOHVIk+iQiEc7VSC1yvB91TivVCzG6n81SF8
RgfSGfKtdOd0KI038TKS+QqmiSoPIXhwgssMMW/GaLVg5G0YrS4cz4oomtEG6kTNOtHxNtHj
QqkkHjBGt2qT1Wy0DhutVqPVbrQ6jdZRo9VttI4PKTo/sOhPS1NW8qm5quS4tZLWs5+I4d4n
IgzpStqp3v9Hg7cebHvYGcfn+YVu3tXHX7p3IyHzEEL/sImO2iB1baIyTgtF1/rsuPwXcc0H
nMHDBQiXOjWF1CsnsT+Ar3SLfhIxTIs1CZ2L4AqocdHPA+7x2gVMQkPuPchq68Pflxd/AOm1
sGUEDQAA

--SUOF0GtieIMvvwua
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="jscal.log.gz"
Content-Transfer-Encoding: base64

H4sICMb7HT0AA2pzY2FsLmxvZwDtl71uwyAUhXc/xd26uJZ/MFjeqnTq1FfADqlpIqiAqO3b
F2xXKS1DMtTTRQh0jrmcz0gMPOlP6+R4hIlb6IB/CAtc7aEqYTg7p5Utsp02RoxOagUHbfwa
aaEEPwxGH4WCk1Qihze/RtqwKHwOVeIgRymU8zsa0cN9UzPK8stcV4SRrqGki0Qyr9o4r944
r9k4j2yc196eV+ah35RCN0lh/3h22Y6f5GC4k+rlsm0P71y6+WLutbpz4PR5nMBNAl7XC1xk
D/O97NeIZYLZrFJmnTKblElSZtuDb/7owrhY9K/FfpUiJEIiJEIiJEIiJEIiJEIiJEJeC/mo
lSjg+cdzay66us1/6R99S1W5yiqWdSybWJJYtrGksWTf8gtC+aIOaBEAAA==

--SUOF0GtieIMvvwua
Content-Type: application/x-gunzip
Content-Disposition: attachment; filename="jstest.log.gz"
Content-Transfer-Encoding: base64

H4sICJH7HT0AA2pzdGVzdC5sb2cA7Y7LCgIhAEX3fcVd1iKZR81Uu6JNURARtLbJJqk0Rifq
77Mx/YI2EwpyDgjXs5QvpXlxQXclS65ZccZCFAR7Lso1FdjWt8OVbeixhzNVGIE+mQIVR8QR
DrXWUiiCecUfrIK5iksBrpCQmESks2NmXZQghKDLhWZVVd81tAR7ct3rTM3aBIjMNScCYm+J
t9TbwNvQW+YtdzazXc2wPJ0+qw0Si9RiYDG0yCxyi5HFuEGoDJWhMlSGyv+s7KdJnuXtqXTW
lkpnbal01pZKZ6EyVH5++L7+uvINtDdT1ysMAAA=

--SUOF0GtieIMvvwua--
