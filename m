Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932362AbVLULKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVLULKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 06:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVLULKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 06:10:42 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:60186 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932362AbVLULKl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 06:10:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=avQ82M50Jm3iXRkYSa+DNwMbKbkHXxQ4tWw39SE6R5Tl9uSjaQdmIRKz/8CXAGw1uOJBglLrNPp2EqwcC3c5A4M4MbwvA9WlDaavP/Z9k8wkx7RRQY/X8P1t9XdL/JR/lJJglZCLdET/F7j2Iyfhg8UcIVJJNxP97/upBhIHaIw=
Message-ID: <a59861030512210310r55f5cdb2o@mail.gmail.com>
Date: Wed, 21 Dec 2005 12:10:40 +0100
From: Ivan Korzakow <ivan.korzakow@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: GPIO device class driver
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I read about a generic device class driver
(http://marc.theaimsgroup.com/?l=linux-kernel&m=109419719600753&w=2)
for GPIO. I wanted to know if anything generic finally came out of the
dicussion ?
I'm willing to write a gpio driver and I am considering taking Robert
Schwebel patch into it if nothing exist in the main line.

Thanks in advance for any info.

Ivan
