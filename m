Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267647AbTAXNHa>; Fri, 24 Jan 2003 08:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267650AbTAXNHa>; Fri, 24 Jan 2003 08:07:30 -0500
Received: from [193.137.96.140] ([193.137.96.140]:65468 "EHLO dwarf.utad.pt")
	by vger.kernel.org with ESMTP id <S267647AbTAXNH2>;
	Fri, 24 Jan 2003 08:07:28 -0500
Message-ID: <3E313AF3.60109@alvie.com>
Date: Fri, 24 Jan 2003 13:09:07 +0000
From: Alvaro Lopes <alvieboy@alvie.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI update (20030122)
References: <F760B14C9561B941B89469F59BA3A84725A131@orsmsx401.jf.intel.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A131@orsmsx401.jf.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grover, Andrew wrote:

>Hi all,
>
>The latest ACPI patch is now available at http://sf.net/projects/acpi .
>Non-Linux packages will be available within 24 hours from
>http://developer.intel.com/technology/iapc/acpi/downloads.htm .
>  
>
Still not working properly :/

Right now with 2.4.21-pre3 keventd 'eats' all my cpu.

Perhaps same problem I got with 2.5.59 (kernel does nothing but handle 
IRQ's from acpi), but at least with 2.4 it gets to boot.

-- 

Álvaro Lopes 
---------------------
A .sig is just a .sig


