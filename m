Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288050AbSA0PQc>; Sun, 27 Jan 2002 10:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288058AbSA0PQX>; Sun, 27 Jan 2002 10:16:23 -0500
Received: from f206.pav2.hotmail.com ([64.4.37.206]:32269 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S288050AbSA0PQT>;
	Sun, 27 Jan 2002 10:16:19 -0500
X-Originating-IP: [210.214.114.220]
From: "kumar M" <kumarm4@hotmail.com>
To: linux-kernel@vger.kernel.org
Cc: kumarm4@hotmail.com
Subject: exporting kernel symbols
Date: Sun, 27 Jan 2002 15:16:10 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F206dZTLOAnjLGXYB1J00005490@hotmail.com>
X-OriginalArrivalTime: 27 Jan 2002 15:16:13.0888 (UTC) FILETIME=[8F1F9C00:01C1A745]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am interested in knowing how mangling the name of symbols
exported by the kernel to include the checksum of the information related to 
that symbol is done, whenever MOD VERSIONS
is used for building a module. Is there any documentation on the
process of the checksum computation, and which portion of the linux
sources I need to go through to understand this ?

TIA.

regards,
Kumar

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp.

