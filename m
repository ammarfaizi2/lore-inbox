Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbWCCRZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbWCCRZE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 12:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbWCCRZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 12:25:04 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:63958 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030252AbWCCRZC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 12:25:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=unsU2AZPbSZ2Ipq9nBbahstquBMOw0HH3cu4H36UdlLNkn77jY6/4E2bpeXekB3TZFdc++929MNxIWbagujjX9a29HCrdvsbfVrdof8RZTJ6v0VMrE312DgAnkTnVxNBzkohpMVbPz7J8Wx0upsQNgUeMhu+Tplx8/1UXaoOSRo=
Message-ID: <44087BF5.90003@gmail.com>
Date: Fri, 03 Mar 2006 14:25:09 -0300
From: Marcos Luiggi Lemos Sartori <marlls1989@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050711)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Software Emulation Layer
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an Idea that could be good to you propuse to the Developers.

I think that all unixs most have a universal binarie (kind you compile
Bash on a BSD and you can run on Linux, Solaris... Without recompile
it), so my Idea is create a plugable automatic kernel Level emulation
for aliens binaries, and root threes for the aliens systems libraries
(such Libc).

And Create a Library Abstraction Layer (kind you have gtk+ on the root
three from the host System, All aliens Binaries can use the GTK+ from
Linux) Because you don't need install multiples copies of a same
Library.

In some time other system will try to copy this scheme, so we will let
it happen because they will provide us their compatiple plug-in and we
will provide our to them. Making all unix more compatiple!

Marcos Sartori

