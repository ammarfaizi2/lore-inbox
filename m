Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751692AbWIYEwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751692AbWIYEwZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 00:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbWIYEwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 00:52:25 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:25650 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750988AbWIYEwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 00:52:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=Vr/02uaas9ry6/iH6WA7uVeWqw1b6WGTl21vda+YBxII1VgI2l0FXGzqO7fjHXG1A3EAHXHolqjd2Dk33zkwRxihql0J474xHqSX3T2LRP6v013uIdq8zWOCzuuLnMLJlADdFTeSGwO7SfJVXBt643GZtjFzWibAt5/iE95lVdk=
Message-ID: <81083a450609242152p18730a09i58728bd2f092f8b6@mail.gmail.com>
Date: Mon, 25 Sep 2006 10:22:24 +0530
From: "Ashutosh Naik" <ashutosh.naik@gmail.com>
To: "Miloslav Trmac" <mitr@volny.cz>,
       "Bernhard Rosenkraenzer" <bero@arklinux.org>, dtor@mail.ru,
       "Andrew Morton" <akpm@osdl.org>
Subject: [PATCH]drivers/input/misc: Added Acer TravelMate 2424NWXCi support to the wistron button interface
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       linux-laptop@vger.kernel.org, GuruPrasad <guruteck@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_24509_6010221.1159159944163"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_24509_6010221.1159159944163
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch adds Acer TravelMate 2424NWXCi support to the wistron button
interface.The key mappings are the same as the older Acer TravelMate
240. I have tested it on my new laptop and it seems to work great.

Signed-off-by: Ashutosh Naik <ashutosh.naik@gmail.com>

------=_Part_24509_6010221.1159159944163
Content-Type: text/plain; name=acer-2424NWXCi-patch.txt; 
	charset=ANSI_X3.4-1968
Content-Transfer-Encoding: base64
X-Attachment-Id: f_esidv4oc
Content-Disposition: attachment; filename="acer-2424NWXCi-patch.txt"

ZGlmZiAtTnVycCBsaW51eC0yLjYuMTgtdmFuaWxsYS9kcml2ZXJzL2lucHV0L21pc2Mvd2lzdHJv
bl9idG5zLmMgbGludXgtMi42LjE4L2RyaXZlcnMvaW5wdXQvbWlzYy93aXN0cm9uX2J0bnMuYwot
LS0gbGludXgtMi42LjE4LXZhbmlsbGEvZHJpdmVycy9pbnB1dC9taXNjL3dpc3Ryb25fYnRucy5j
CTIwMDYtMDktMjAgMDk6MTI6MDYuMDAwMDAwMDAwICswNTMwCisrKyBsaW51eC0yLjYuMTgvZHJp
dmVycy9pbnB1dC9taXNjL3dpc3Ryb25fYnRucy5jCTIwMDYtMDktMjUgMTA6MTI6MjMuMDAwMDAw
MDAwICswNTMwCkBAIC0zODksNiArMzg5LDE1IEBAIHN0YXRpYyBzdHJ1Y3QgZG1pX3N5c3RlbV9p
ZCBkbWlfaWRzW10gX18KIAkJfSwKIAkJLmRyaXZlcl9kYXRhID0ga2V5bWFwX2FjZXJfdHJhdmVs
bWF0ZV8yNDAKIAl9LAorCXsKKwkJLmNhbGxiYWNrID0gZG1pX21hdGNoZWQsCisJCS5pZGVudCA9
ICJBY2VyIFRyYXZlbE1hdGUgMjQyNE5XWENpIiwKKwkJLm1hdGNoZXMgPSB7CisJCQlETUlfTUFU
Q0goRE1JX1NZU19WRU5ET1IsICJBY2VyIiksCisJCQlETUlfTUFUQ0goRE1JX1BST0RVQ1RfTkFN
RSwgIlRyYXZlbE1hdGUgMjQyMCIpLAorCQl9LAorCQkuZHJpdmVyX2RhdGEgPSBrZXltYXBfYWNl
cl90cmF2ZWxtYXRlXzI0MAorCX0sCiAgICAgICAgIHsKIAkJLmNhbGxiYWNrID0gZG1pX21hdGNo
ZWQsCiAJCS5pZGVudCA9ICJBT3BlbiAxNTU5QVMiLAo=
------=_Part_24509_6010221.1159159944163--
