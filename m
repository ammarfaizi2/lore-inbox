Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750874AbWELEC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWELEC1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 00:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWELEC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 00:02:27 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:40498 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750867AbWELEC1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 00:02:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GoikqcEtlvJ617oBReUg3KjDBS7HkNkDmAP8S0dLkCs7z9BkMRTjL97ngZbgoDkidBL3cLW9E55D1JAd5UjUjnXTrxaticcolcEW5OGW/9m3U+Y4D4c6J0vm2PQW7uzNHHa0VRYgB4J38axM5sHuTOCTsFF+wFUwUglgy3ZlRm0=
Message-ID: <bda6d13a0605112102m70b20772y946d149b6f8bd56@mail.gmail.com>
Date: Thu, 11 May 2006 21:02:26 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc4 mucked .config
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Imported .config from 2.6.16.1
ran "make" to prompt for fill in new values

Found it automatically set on USB storage driver, some sound driver,
and "Video for Linux".
Possibly also the parallel port, or maybe that was already on.
Didn't prompt for any of these

Noticed after kernel was some 500k larger than expected.
