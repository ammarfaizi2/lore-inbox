Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030199AbVLVRE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030199AbVLVRE1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 12:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbVLVRE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 12:04:27 -0500
Received: from web34108.mail.mud.yahoo.com ([66.163.178.106]:29887 "HELO
	web34108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030199AbVLVRE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 12:04:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=RfuRJsiL6ZWc54t4vTBpH48ZzomkdNHvL79kOXYvjI7o9GOBv/tGvgz3+dNmmpQKlYWNLS/oHvB49pjytx600u2nnPLrbYsyrWKKD+uHjx/U/q0Z4D/gzARFpHnQtALv1dNDsj35m0iOCEd5P4WDn6X27RC2Ycqmqt8SVjoK9Y0=  ;
Message-ID: <20051222170426.39259.qmail@web34108.mail.mud.yahoo.com>
Date: Thu, 22 Dec 2005 09:04:26 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: RE: scsi errors with dpt-i2o driver
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F01FB3AC6@otce2k03.adaptec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "Salyzyn, Mark" <mark_salyzyn@adaptec.com> wrote:
> (often can be fixed by a firmware update to the drive)

Sir, I believe you have nailed it: http://www.seagate.com/support/disc/u320_firmware.html

Though, I am still troubled that a single unhappy drive can impact a system so severely -
especially since we pile them up for RAID thereby increasing the probability of a disk being
unhappy.

-Kenny




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
