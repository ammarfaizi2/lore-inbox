Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270101AbSKEByh>; Mon, 4 Nov 2002 20:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270100AbSKEByg>; Mon, 4 Nov 2002 20:54:36 -0500
Received: from fmr01.intel.com ([192.55.52.18]:2532 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S270096AbSKEByf>;
	Mon, 4 Nov 2002 20:54:35 -0500
Message-ID: <01f001c2846f$34d55e30$7fd40a0a@amr.corp.intel.com>
From: "Geoff Gustafson" <geoff@linux.co.intel.com>
To: "Andreas Dilger" <adilger@clusterfs.com>, <linux-kernel@vger.kernel.org>
References: <000a01c28454$56a94b90$7fd40a0a@amr.corp.intel.com> <3DC6FF60.2000100@pobox.com> <20021104163113.B13741@munet-d.enel.ucalgary.ca>
Subject: Re: RFC: A POSIX Linux project?
Date: Mon, 4 Nov 2002 18:01:08 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> What about the existing POSIX test suite from X/Open?  I don't know what
> the current license is, but it is certainly freely downloadable from
> their website.  However, it is a pain in the a** to set up and run, so
> a new version would definitely be welcome.

If I understand correctly, the test suites that cover POSIX extensions more
recent than 1990 are not free. Also, these use the TET framework, whereas this
project hopes to keep tests very simple and standalone, so the code can be
immediately sent to and warmly received by developers if bugs are found.

http://www.opengroup.org/testing/sales+support/prices.htm#VSTRC

-- Geoff Gustafson

These are my views and not necessarily those of my employer.

