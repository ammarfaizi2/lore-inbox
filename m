Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261578AbTDBTbh>; Wed, 2 Apr 2003 14:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261620AbTDBTbh>; Wed, 2 Apr 2003 14:31:37 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:48823 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261578AbTDBTbg>; Wed, 2 Apr 2003 14:31:36 -0500
Date: Wed, 02 Apr 2003 11:33:01 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 533] New: Some PnP Devices - USR Robotics modem do not have a generic name
Message-ID: <172830000.1049311981@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=533

           Summary: Some PnP Devices - USR Robotics modem do not have a
                    generic name
    Kernel Version: 2.5.5x-2.5.66-bk3+
            Status: NEW
          Severity: normal
             Owner: ambx1@neo.rr.com
         Submitter: spstarr@sh0n.net


Distribution: LFS
Hardware Environment: IBM 300PL 6892-N2U (Katmai) 300Mhz
Problem Description: the ID USR0006's PnP name entry in the generic driver name
file is missing, should be "U.S. Robotics Sportster 33600 FAX/Voice Int" this is
displayed when PnP detects the device on boot however.

Currently, it is empty (null).

