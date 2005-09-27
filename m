Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbVI0VLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbVI0VLf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 17:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbVI0VLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 17:11:35 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:5708 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965019AbVI0VLf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 17:11:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DRqzPk+A6ZUp9PONSfPEoFPHqllqD9Xe5GTAPTWq2am1Boq23cT69u8aXKSiatbTDcnPWjbv/UPqAJKQgLPjz4QrXPt5wvP+8/VHkSqnL6P3I/OmDTD/FZ6lht4tYLPJGCDqLZcwE8wOdNleeRh1Kh60R59N6YErLnbbJy4YGo4=
Message-ID: <460afdfa050927141140b63c0@mail.gmail.com>
Date: Tue, 27 Sep 2005 23:11:32 +0200
From: Luca <luca.foppiano@gmail.com>
Reply-To: Luca <luca.foppiano@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: error audio card
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have an error when the kernel start to load the audio card:

hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...
hda_codec: num_steps = 0 for NID=0x8
hda_codec: num_steps = 0 for NID=0x9
hda_codec: num_steps = 0 for NID=0x9
hda_codec: num_steps = 0 for NID=0x9
hda_codec: num_steps = 0 for NID=0x9
hda_codec: num_steps = 0 for NID=0x9
hda_codec: num_steps = 0 for NID=0x9
hda_codec: num_steps = 0 for NID=0x9
hda_codec: num_steps = 0 for NID=0x9
hda_codec: num_steps = 0 for NID=0x9
hda_codec: num_steps = 0 for NID=0x9
hda_codec: num_steps = 0 for NID=0x9
hda_codec: num_steps = 0 for NID=0x9
hda_codec: num_steps = 0 for NID=0x9
hda_codec: num_steps = 0 for NID=0x9
hda_codec: num_steps = 0 for NID=0x9
hda_codec: num_steps = 0 for NID=0x9

Why this error? Why somethimes?

tnks
Luca
