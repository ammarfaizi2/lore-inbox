Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279144AbRJaUlD>; Wed, 31 Oct 2001 15:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280493AbRJaUky>; Wed, 31 Oct 2001 15:40:54 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:17303 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S279144AbRJaUkq>;
	Wed, 31 Oct 2001 15:40:46 -0500
Date: Wed, 31 Oct 2001 20:41:20 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: "Grover, Andrew" <andrew.grover@intel.com>,
        "'Alex Bligh - linux-kernel'" <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: RE: 2xQ: Is PM + ACPI but /no/ APM a valid configuration?
 Interru	pts enabled in APM set power state?
Message-ID: <279742847.1004560880@[195.224.237.69]>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D6DA@orsmsx111.jf.intel.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D6DA@orsmsx111.jf.intel.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

--On Wednesday, 31 October, 2001 11:26 AM -0800 "Grover, Andrew" 
<andrew.grover@intel.com> wrote:

>> From: Alex Bligh - linux-kernel [mailto:linux-kernel@alex.org.uk]
>> PM, ACPI, no APM
>>
>> This is the wierd one. I get a pile of scrolly
>> messages which I think is ACPI debugging
>> and appear to be uninterruptible - SysRq K crashes
>> the machine. They are attached at the bottom.
>>
>> Is this a valid configuration? I can't see why
>> not.
>
> If I may interpret the debug messages...do they go away if you compile in
> the ACPI embedded controller driver? That appears to be part (if not all)
> of the problem.

For the hard of understanding, such as myself, do you mean the
ACPI bus manager (CONFIG_ACPI_BUSMGR)? I had that unset, on
the basis of least change, but can try it, or did you mean
something else?

--
Alex Bligh
