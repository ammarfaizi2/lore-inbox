Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314458AbSDRVDI>; Thu, 18 Apr 2002 17:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314459AbSDRVDH>; Thu, 18 Apr 2002 17:03:07 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:19869 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S314458AbSDRVDG>; Thu, 18 Apr 2002 17:03:06 -0400
Subject: Re: power off (again)
From: "Trever L. Adams" <tadams-lists@myrealbox.com>
To: Christian Schoenebeck <christian.schoenebeck@epost.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020418201220.C6D6247B1@debian.heim.lan>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3.99 
Date: 18 Apr 2002 14:02:43 -0700
Message-Id: <1019163766.6743.8.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just out of curiosity, have you changed your power off scripts to
reflect: "halt -p".  I can't remember where you make this change on
RedHat, but I had to make it to make 2.4.x work for power down (Actually
it was 2.3.xx where the change was made, I believe).

Trever

