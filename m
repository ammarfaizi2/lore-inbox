Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131479AbRCNRh2>; Wed, 14 Mar 2001 12:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131483AbRCNRhS>; Wed, 14 Mar 2001 12:37:18 -0500
Received: from customer-203-176-1-28.ip.iphil.net ([203.176.1.28]:1284 "HELO
	maravillo") by vger.kernel.org with SMTP id <S131479AbRCNRhD>;
	Wed, 14 Mar 2001 12:37:03 -0500
Date: Thu, 15 Mar 2001 01:35:44 +0800
From: Mike Maravillo <mike.maravillo@q-linux.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.2-ac20: Trying to vfree() nonexistent vm area (c8138000)
Message-ID: <20010315013542.A2228@maravillo.maravillo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Organization: Q Linux Solutions, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

The following appeared on my home box running 2.4.2-ac20.  I have
X, netscape, and broadcast2000 running on it when this happened.
The system is still up, though I have the slightest idea what to
check next... any ideas?

Mar 15 00:58:25 mmj kernel: Trying to vfree() nonexistent vm area (c8138000)
Mar 15 00:58:41 mmj kernel: Trying to vfree() nonexistent vm area (c8138000)

-- 
 .--.  Michael J. Maravillo                   office://+63.2.894.3592/
( () ) Q Linux Solutions, Inc.              mobile://+63.917.897.0919/
 `--\\ A Philippine Open Source Solutions Co.  http://www.q-linux.com/
