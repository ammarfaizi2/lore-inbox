Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280508AbRJaVCB>; Wed, 31 Oct 2001 16:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280507AbRJaVBv>; Wed, 31 Oct 2001 16:01:51 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:26263 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S280506AbRJaVBd>;
	Wed, 31 Oct 2001 16:01:33 -0500
Date: Wed, 31 Oct 2001 21:02:06 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        "Grover, Andrew" <andrew.grover@intel.com>,
        linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: RE: 2xQ: Is PM + ACPI but /no/ APM a valid configuration?
 Interru	pts enabled in APM set power state?
Message-ID: <280989012.1004562126@[195.224.237.69]>
In-Reply-To: <279742847.1004560880@[195.224.237.69]>
In-Reply-To: <279742847.1004560880@[195.224.237.69]>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For the hard of understanding, such as myself, do you mean the
> ACPI bus manager (CONFIG_ACPI_BUSMGR)? I had that unset, on
> the basis of least change, but can try it, or did you mean
> something else?

This was a stupid question derived from being up too many
hours. Andrew obviously meant 'embedded controller', the config
option for which depends on bus manager being selected
too. Apols.

Is selecting ACPI without these an invalid config? Or just
on my laptop?

--
Alex Bligh
