Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318071AbSGWOa5>; Tue, 23 Jul 2002 10:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318072AbSGWOa5>; Tue, 23 Jul 2002 10:30:57 -0400
Received: from ns.aspic.com ([213.193.2.5]:30736 "EHLO off.aspic.com")
	by vger.kernel.org with ESMTP id <S318071AbSGWOa4>;
	Tue, 23 Jul 2002 10:30:56 -0400
Date: Tue, 23 Jul 2002 16:34:03 +0200
From: Philippe =?ISO-8859-1?B?R3JhbW91bGzp?= 
	<philippe.gramoulle@mmania.com>
To: jamesclv@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Summit patch for 2.4.19-rc3-ac2
Message-Id: <20020723163403.37e3b163.philippe.gramoulle@mmania.com>
In-Reply-To: <200207222121.04788.jamesclv@us.ibm.com>
References: <200207222121.04788.jamesclv@us.ibm.com>
Organization: Lycos Europe
X-Mailer: Sylpheed version 0.8.0claws1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2002 21:21:04 -0700
James Cleverdon <jamesclv@us.ibm.com> wrote:

Thanks, it works now on both DELL MT 530 (2xPIII Xeon 1.5Ghz) and DELL 2450 ( 2xPIII Copermine 1gHZ).

Before, the MT 530 was halted on the SCSI probe while the 2450 was stucked with the APIC error message
on CPU #0

Thanks,

Philippe.

  |  This fixes the APIC receive accept errors on the two machines we have that 
  |  were subject to it.  Let me know if it doesn't work for you.
  |  
  |  -- 
  |  James Cleverdon
  |  IBM xSeries Linux Solutions
  |  {jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com
  |  
