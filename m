Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287106AbSA2Xf5>; Tue, 29 Jan 2002 18:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287109AbSA2Xee>; Tue, 29 Jan 2002 18:34:34 -0500
Received: from ns.suse.de ([213.95.15.193]:49156 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287045AbSA2Xds>;
	Tue, 29 Jan 2002 18:33:48 -0500
Date: Wed, 30 Jan 2002 00:33:46 +0100
From: Dave Jones <davej@suse.de>
To: Pozsar Balazs <pozsy@sch.bme.hu>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.2-dj7
Message-ID: <20020130003346.A16379@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Pozsar Balazs <pozsy@sch.bme.hu>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020129225526.A3064@suse.de> <Pine.GSO.4.30.0201300018450.940-100000@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.30.0201300018450.940-100000@balu>; from pozsy@sch.bme.hu on Wed, Jan 30, 2002 at 12:19:27AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 12:19:27AM +0100, Pozsar Balazs wrote:
 > > 2.5.2-dj7
 > > o   Workaround some broken PS/2 mice.			(Vojtech Pavlik)
 > What is this about exactly?

 Some PS2 mice forget to ACK the GetID command before sending
 a response.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
