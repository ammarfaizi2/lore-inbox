Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135513AbRDSCQ6>; Wed, 18 Apr 2001 22:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135517AbRDSCQt>; Wed, 18 Apr 2001 22:16:49 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:62127 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135513AbRDSCQc>;
	Wed, 18 Apr 2001 22:16:32 -0400
Message-ID: <3ADE4A78.E9DF2377@mandrakesoft.com>
Date: Wed, 18 Apr 2001 22:16:24 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-19mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDD9D@orsmsx35.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" wrote:
> ACPI has by far the richest set of capabilities. It is a superset of APM.
> Therefore a combined APM/ACPI interface is going to look a lot like an ACPI
> interface.
> 
> IMHO an abstracted interface at this point is overengineering. Maybe later
> it will make sense, though.

IMHO We want to be able to support at least three cases:  APM, ACPI, and
native PM.

-- 
Jeff Garzik       | "The universe is like a safe to which there is a
Building 1024     |  combination -- but the combination is locked up
MandrakeSoft      |  in the safe."    -- Peter DeVries
