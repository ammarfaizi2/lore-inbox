Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318261AbSG3NVK>; Tue, 30 Jul 2002 09:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318262AbSG3NVK>; Tue, 30 Jul 2002 09:21:10 -0400
Received: from [213.69.213.4] ([213.69.213.4]:10651 "EHLO i-t-c-s.de")
	by vger.kernel.org with ESMTP id <S318261AbSG3NVJ> convert rfc822-to-8bit;
	Tue, 30 Jul 2002 09:21:09 -0400
X-AuthUser: tmi@wikon.de
Content-Type: text/plain; charset=US-ASCII
From: Thomas Mierau <tmi@wikon.de>
Organization: WIKON Kommunikationstechnik GmbH
To: linux-kernel@vger.kernel.org
Subject: Re: Tyan K7X with AMD MP 2.4.19-rc3-ac4
Date: Tue, 30 Jul 2002 15:26:08 +0200
X-Mailer: KMail [version 1.4]
References: <200207301421.18701.tmi@wikon.de>
In-Reply-To: <200207301421.18701.tmi@wikon.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207301525.57827.tmi@wikon.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-30 at 13:21, Thomas Mierau wrote:
>> Hi
>> 
>> I am trying to get the above board to work. Somehow it doesn't.
>> I tried kernel  2.4.18, 2.4.19-rc3, 2.4.19-rc3-ac3 and of course the latest 
>> 2.4.19-rc3-ac4
>> 
>> The machine itself is "working" stable under 2.4.18 with a limited 
>> functionality (no network, no additional scsi ports, no printer, no usb 
...)

>Start by disabling acpi support


Done.
Doesn't change anything. Actually I started without any acpi before
The dmesg looks quiet the same just without the acpi stuff.

The machine freezed again after a while. I have another strange effect during 
make which might be related to the same problem. In version  2.4.18 I can 
compile the kernel as I like.
Since 2.4.19-rc3 the machine freezes during compilation. If I use the option 
"make -j" I don't have any problems.

