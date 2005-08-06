Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263339AbVHFRxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263339AbVHFRxb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 13:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263341AbVHFRxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 13:53:31 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:223 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263339AbVHFRx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 13:53:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:reply-to:mail-followup-to:mime-version:content-type:content-disposition;
        b=A3D2Ngzn/BKLCuiwUZGhMHnB4sghiuRrqsi1RjUE+14Lfw2sP7cohzTQjTi9TUSJpmYPP5gRlE/oXXqzvUVJA8HVKizFNtGHBIj6NyB+6lXNnaFsDBOQz3FyXo/Sf221/BwgRVCrMblFXF7Rrl3gqzLDe0aDaj3kwAAvJS/OVrE=
Date: Sat, 6 Aug 2005 19:58:23 +0200
From: Mateusz Berezecki <mateuszb@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: broadcom 4401 stopped working
Message-ID: <20050806175823.GA7815@ntjohd.mshome.net>
Reply-To: Mateusz Berezecki <mateuszb@gmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list readers

For those who do not track netdev list a quick recap

I fetched latest netdev tree ieee80211 branch and my broadcom 4401
network card stopped working.

I had some time recently and ran few tests. Compiling kernel without
ACPI support didn't help a lot, though compiling without any Power
Management made my card work again. I would apreciate any input on this
issue from some PM person. What are potential changes which could have
affected the card's behaviour? I am really short on time and unable to
do any investigation until september.


kind regards
Mateusz




