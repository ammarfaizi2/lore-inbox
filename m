Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129212AbRBTN4K>; Tue, 20 Feb 2001 08:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129551AbRBTN4A>; Tue, 20 Feb 2001 08:56:00 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:10244 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129212AbRBTNzv>; Tue, 20 Feb 2001 08:55:51 -0500
Date: Tue, 20 Feb 2001 14:55:23 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: "Butter, Frank" <Frank.Butter@otto.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: kernel params
Message-ID: <20010220145523.G8042@arthur.ubicom.tudelft.nl>
In-Reply-To: <4B6025B1ABF9D211B5860008C75D57CC0271B905@NTOVMAIL04>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4B6025B1ABF9D211B5860008C75D57CC0271B905@NTOVMAIL04>; from Frank.Butter@otto.de on Tue, Feb 20, 2001 at 01:54:04PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 20, 2001 at 01:54:04PM +0100, Butter, Frank wrote:
> Is there any possibility to set the values for IPC-ressources
> (SHM/SEM) other than by changing the headerfiles?

Sure, that's what sysctl is for. See sysctl(8) or /proc/sys/kernel/ .


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
