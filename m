Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311969AbSCZNbw>; Tue, 26 Mar 2002 08:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311959AbSCZNbn>; Tue, 26 Mar 2002 08:31:43 -0500
Received: from saiya-jin.flinthills.com ([64.39.192.211]:55687 "EHLO
	saiya-jin.flinthills.com") by vger.kernel.org with ESMTP
	id <S311881AbSCZNbR>; Tue, 26 Mar 2002 08:31:17 -0500
Subject: [Fwd: Re: [Fwd: lilo-xfs patch]]
From: Derek James Witt <djw@flinthills.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-ryfIIG8p6LGtULswK8qz"
X-Mailer: Evolution/1.0.2 
Date: 26 Mar 2002 07:24:20 -0600
Message-Id: <1017149061.1730.23.camel@saiya-jin.flinthills.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ryfIIG8p6LGtULswK8qz
Content-Type: multipart/mixed; boundary="=-yhpOl//dM1zLFqwfcmhk"


--=-yhpOl//dM1zLFqwfcmhk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

If you're already subscribed to the XFS mailing list, please disregard.
I apologize in advance.
-----------------------------------------------------------------------

Hi, all. If you're running XFS on any of your partition (and not
subcribed to the XFS mailing list), this patch may  be of value. It
simply aborts lilo when XFS is detected, and for the bold (???), I added
a -F parameter to force lilo to continue.
--=20
**  Derek J Witt                                              **
*   Email: mailto:djw@flinthills.com                           *
*   Home Page: http://www.flinthills.com/~djw/                 *
*** "...and on the eighth day, God met Bill Gates." - Unknown **

--=-yhpOl//dM1zLFqwfcmhk
Content-Disposition: inline
Content-Description: Forwarded message - Re: [Fwd: lilo-xfs patch]
Content-Type: message/rfc822

Return-Path: <owner-linux-xfs@oss.sgi.com>
Received: from localhost (fetchmail@localhost [127.0.0.1]) by
	saiya-jin.flinthills.com (8.12.2/8.12.2/Debian -5) with ESMTP id
	g2PN0WQh030511 for <cappicard@localhost>; Mon, 25 Mar 2002 17:00:32 -0600
Received: from konza.flinthills.com [64.39.200.1] by localhost with IMAP
	(fetchmail-5.9.10) for cappicard@localhost (single-drop); Mon, 25 Mar 2002
	17:00:32 -0600 (CST)
Received: from oss.sgi.com (oss.sgi.com [216.32.174.27]) by
	konza.flinthills.com (8.12.0.Beta7/8.12.0.Beta7) with ESMTP id
	g2PN4wXQ005634 for <djw@flinthills.com>; Mon, 25 Mar 2002 17:04:58 -0600
	(CST)
Received: from localhost (mail@localhost) by oss.sgi.com (8.11.2/8.11.3)
	with SMTP id g2PMv8v00926; Mon, 25 Mar 2002 14:57:08 -0800
X-Authentication-Warning: oss.sgi.com: mail owned process doing -bs
Received: by oss.sgi.com (bulk_mailer v1.13); Mon, 25 Mar 2002 14:57:04
	-0800
Received: (from majordomo@localhost) by oss.sgi.com (8.11.2/8.11.3) id
	g2PMv4l00871 for linux-xfs-outgoing; Mon, 25 Mar 2002 14:57:04 -0800
Received: from saiya-jin.flinthills.com (root@saiya-jin.flinthills.com
	[64.39.192.211]) by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2PMuhq00841
	for <linux-xfs@oss.sgi.com>; Mon, 25 Mar 2002 14:56:43 -0800
Received: from saiya-jin.flinthills.com (cappicard@localhost [127.0.0.1])
	by saiya-jin.flinthills.com (8.12.2/8.12.2/Debian -5) with ESMTP id
	g2PMqPQf030458 for <linux-xfs@oss.sgi.com>; Mon, 25 Mar 2002 16:52:25 -0600
Received: (from cappicard@localhost) by saiya-jin.flinthills.com
	(8.12.2/8.12.2/Debian -5) id g2PMqPSe030456; Mon, 25 Mar 2002 16:52:25 -0600
X-Authentication-Warning: saiya-jin.flinthills.com: cappicard set sender to
	djw@flinthills.com using -f
Subject: Re: [Fwd: lilo-xfs patch]
From: Derek James Witt <djw@flinthills.com>
To: Linux XFS <linux-xfs@oss.sgi.com>
In-Reply-To: <1017093184.1748.32.camel@stout.americas.sgi.com>
In-Reply-To: <1017092300.2173.13.camel@saiya-jin.flinthills.com> 
	<1017093184.1748.32.camel@stout.americas.sgi.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-cOzvY6JJkswPwgvV9tWz"
X-Mailer: Evolution/1.0.2 
Date: 25 Mar 2002 16:52:25 -0600
Message-Id: <1017096745.2172.18.camel@saiya-jin.flinthills.com>
Mime-Version: 1.0
Sender: owner-linux-xfs@oss.sgi.com
Precedence: bulk
X-Spam-Status: No, hits=-5.0 required=5.0 tests=IN_REP_TO version=2.11


--=-cOzvY6JJkswPwgvV9tWz
Content-Type: multipart/mixed; boundary="=-E3OV9iMAwk6Ln+NS+iY5"


--=-E3OV9iMAwk6Ln+NS+iY5
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi, Eric. Thanks for the suggestion. That made it cleaner. Here's the
new patch.

On Mon, 2002-03-25 at 15:53, Eric Sandeen wrote:
> hi Derek -=20
>=20
> Rather than parsing /etc/mtab, it would probably be better to look for
> "XFSB" in the first 4 bytes of the target partition - that way you
> _know_ the target has (or has had....) an xfs filesystem on it.
>=20
> -Eric
>=20
> --=20
> Eric Sandeen      XFS for Linux     http://oss.sgi.com/projects/xfs
> sandeen@sgi.com   SGI, Inc.
--=20
**  Derek J Witt                                              **
*   Email: mailto:djw@flinthills.com                           *
*   Home Page: http://www.flinthills.com/~djw/                 *
*** "...and on the eighth day, God met Bill Gates." - Unknown **

--=-E3OV9iMAwk6Ln+NS+iY5
Content-Disposition: attachment; filename=lilo-xfs.diff
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

--- lilo.c	Sun Dec 30 16:10:26 2001
+++ ../lilo-xfs.c	Mon Mar 25 16:43:40 2002
@@ -755,16 +755,40 @@
     fprintf(errstd,"%7s%s -A /dev/XXX [ N ]\t\tactivate a partition\n","",=
name);
     fprintf(errstd,"%7s%s -M /dev/XXX [ mbr_file ]\tinstall master boot re=
cord\n","",name);
     fprintf(errstd,"%7s%s -T help \t\t\tlist additional options\n", "", na=
me);
+    fprintf(errstd,"%7s%s -F \t\t\t\tforce install on XFS partition\n\t\t\=
t\t\tWARNING: This will corrupt\n\t\t\t\t\tthe superblock on XFS partitions=
.\n\n", "", name);
     fprintf(errstd,"%7s%s -V [ -v ]\t\t\tversion information\n\n","",name)=
;
     exit(1);
 }
=20
=20
+int is_xfs(char* device)=20
+{
+    FILE* mounts;
+    unsigned char xfs_sig[] =3D {'X','F','S','B'};
+    int got_xfs =3D 1, i;
+
+    if ((mounts =3D fopen(device, "rb")) =3D=3D NULL)=20
+    {   /* Just some insurance. If this does not exists, there's something
+	   seriously wrong here. How are you even in Linux in the first place?
+	*/
+	die("ERROR: I cannot find %s! Nothing done.\n",device);
+    }
+
+    for (i =3D 0; (i < 4) && (got_xfs =3D=3D 1); i++)=20
+      if (xfs_sig[i] =3D=3D fgetc(mounts)) got_xfs =3D 1; else got_xfs =3D=
 0;
+
+    fclose(mounts);
+
+    return got_xfs;
+}
+
 int main(int argc,char **argv)
 {
     char *name,*reboot_arg,*identify,*ident_opt,*new_root;
     char *tell_param, *uninst_dev, *param, *act1, *act2, ch;
     int query,more,version,uninstall,validate,activate,instmbr,geom;
+    int force_xfs;
+    char *boot_device =3D NULL;
     struct stat st;
     int fd;
     long raid_offset;
@@ -775,6 +799,7 @@
 	    reboot_arg =3D identify =3D ident_opt =3D new_root =3D uninst_dev =3D=
 NULL;
     lowest =3D do_md_install =3D zflag =3D
 	    query =3D version =3D uninstall =3D validate =3D activate =3D instmbr=
 =3D 0;
+    force_xfs =3D 0;
     verbose =3D -1;
     name =3D *argv;
     argc--;
@@ -806,6 +831,8 @@
 		break;
 	    case 'b':
 		cfg_set(cf_options,"boot",param,NULL);
+		boot_device =3D (char*)malloc((sizeof (char)) * 255);
+		strcpy(boot_device,param);
 		break;
 	    case 'c':
 		cfg_set(cf_options,"compact",NULL,NULL);
@@ -823,6 +850,11 @@
 	    case 'f':
 		cfg_set(cf_options,"disktab",param,NULL);
 		break;
+            case 'F':
+	        if (!nowarn)
+		    fprintf(errstd,"WARNING: Forcing install on XFS partitions...\nBe pr=
epared to run xfs_repair\non any XFS root partitions\nthat LILO selects as =
boot.\n");
+		force_xfs =3D 1;
+		break;
 	    case 'g':
 		geometric |=3D 1;
 		break;
@@ -1104,6 +1136,13 @@
 	if (verbose >=3D2 && do_md_install)
 	    printf("raid flags: at bsect_open  0x%02X\n", raid_flags);
=20
+	if (boot_device =3D=3D NULL)
+	{
+	    boot_device =3D (char*)malloc((sizeof (char)) * 255);
+	    strcpy(boot_device,cfg_get_strg(cf_options,"boot"));
+	}
+	if ((is_xfs(boot_device) =3D=3D 1) && (force_xfs =3D=3D 0)) die("root (%s=
) is XFS. Aborted.",boot_device);
+=09
 	bsect_open(cfg_get_strg(cf_options,"boot"),cfg_get_strg(cf_options,"map")=
 ?
 	  cfg_get_strg(cf_options,"map") : MAP_FILE,cfg_get_strg(cf_options,
 	  "install"),cfg_get_strg(cf_options,"delay") ? to_number(cfg_get_strg(

--=-E3OV9iMAwk6Ln+NS+iY5--

--=-cOzvY6JJkswPwgvV9tWz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8n6opgnGXTpcv6TgRAukEAJ4oy7P8iyTeDF973fS4M8YOyjKtowCggtxG
wOvBz2bzZzIhPPrI1rSmlZE=3D
=3DnuxL
-----END PGP SIGNATURE-----

--=-cOzvY6JJkswPwgvV9tWz--

--=-yhpOl//dM1zLFqwfcmhk--

--=-ryfIIG8p6LGtULswK8qz
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8oHaEgnGXTpcv6TgRAkgdAJ43uYPlwaQtYkWODsmZw3dMlsrH8gCgs3Ae
66yeombvTv/axcgglrlt/zA=
=Jj/a
-----END PGP SIGNATURE-----

--=-ryfIIG8p6LGtULswK8qz--
